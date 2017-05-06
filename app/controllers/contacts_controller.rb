# class ContactsController < ApplicationController
#   def index
#   end
# end

# class BlogsController < ApplicationController
class ContactsController < ApplicationController

  # def index
  #   # @blogs = Blog.all
  #   @contacts = Contact.all
  # end
  
  def new
    # @blog = Blog.new
    if params[:back]
      @contact = Contact.new(contacts_params)
    else
      @contact = Contact.new
    end
  end

  def create
    # Blog.create(blogs_params)
    # redirect_to blogs_path
    # Contact.create(contacts_params)
    # redirect_to new_contact_path
    @contact = Contact.new(contacts_params)
    if @contact.save
      # redirect_to new_contact_path,notice: "お問い合わせありがとうございました！"
      redirect_to root_path, notice: "問い合わせが完了しました！"
    else
      render 'new'
    end
  end
  
  # def edit
  #   @blog = Blog.find(params[:id])
  # end
  
  def confirm
    @contact = Contact.new(contacts_params)
    render :new if @contact.invalid?
  end

    private
        # def blogs_params
        #   params.require(:blog).permit(:title, :content)
        # end
        def contacts_params
          params.require(:contact).permit(:name, :email, :content)
        end

end
