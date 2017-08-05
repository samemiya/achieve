# DIVE14_API基礎編２で編集
# APIの演習
class PoemsController < ApplicationController
  def index
    @poems = Poem.all
  end

  def show
    @poem = Poem.find(params[:id])
    # @poems = Poem.find
  end

  def edit
    # set_poem
  end
  
  def update
    @poem = Poem.find(params[:id])
    if @poem.update(poems_params)
      redirect_to poems_path, notice: "ポエムを更新しました！"
    else
      render 'edit'
    end
  end
  
  def destroy
    set_poem
    @poem.destroy
    redirect_to poems_path, notice: "ポエムを削除しました！"
  end
  
  private
      def poems_params
        params.require(:poem).permit(:title, :content)
      end

      # idをキーとして値を取得するメソッド
      def set_blog
        @poem = Poem.find(params[:id])
      end

end
