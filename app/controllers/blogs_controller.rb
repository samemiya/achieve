class BlogsController < ApplicationController
  # DIVE15_コメント機能 で編集　
  # onlyにshowアクションを追加します。
  before_action :authenticate_user!
  before_action :set_blog, only: [:show, :edit, :update, :destroy]  
  
  def index
    @blogs = Blog.all
    
    # DIVE13_デバック：エラーページ　で編集
    # 処理を途中で止めて、状況を確認する
    # binding.pry
    
    # 同じように途中で止める　違いは何だろう？
    # raise
    
  end

  # DIVE15_コメント機能 で編集　
  # showアククションを定義します。入力フォームと一覧を表示するためインスタンスを2つ生成します。
  def show
    @comment = @blog.comments.build
    @comments = @blog.comments
  end
  
  def new
    if params[:back]
      @blog = Blog.new(blogs_params)
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = Blog.new(blogs_params)
    @blog.user_id = current_user.id
    @blog.user_name = current_user.name
    if @blog.save
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to blogs_path, notice: "ブログを作成しました！"    
      NoticeMailer.sendmail_blog(@blog).deliver
    else
      # 入力フォームを再描画します。
      render 'new' 
    end

    # Blog.create(blogs_params)
    # redirect_to blogs_path, notice: "ブログを作成しました！"
  end
  
  def edit
    # edit, update, destroyで共通コード
    set_blog
    # @blog = Blog.find(params[:id])
  end
  
  def update
    # edit, update, destroyで共通コード
    # set_blog
    @blog = Blog.find(params[:id])
    # @blog.user_id = current_user.id
    if @blog.update(blogs_params)
      redirect_to blogs_path, notice: "ブログを更新しました！"
    else
      render 'edit'
    end
  end
  
  def destroy
    # edit, update, destroyで共通コード
    set_blog
    # @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice: "ブログを削除しました！"
  end
  
  def confirm
    @blog = Blog.new(blogs_params)
    render :new if @blog.invalid?
  end

  private
      def blogs_params
        params.require(:blog).permit(:title, :content)
      end

      # idをキーとして値を取得するメソッド
      def set_blog
        @blog = Blog.find(params[:id])
      end

end
