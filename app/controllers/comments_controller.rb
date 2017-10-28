class CommentsController < ApplicationController
  # DIVE15_コメント機能 で編集
  # 下記を追加　
  # コメントを保存、投稿するためのアクション
  def create
    # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildする
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    # DIVE19_2_通知機能 で編集  
    # コメント投稿の際に、Notificationが作成されるようにする
    @notification = @comment.notifications.build(user_id: @blog.user.id )
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました。' }
        # DIVE15_コメント機能 で編集
        # JS形式でレスポンスを返す
        format.js { render :index }
        # DIVE19_2_通知機能 で編集 
        # コメントされたことを通知する
        # 下の書き方だと全員に通知されてしまう
        # 次のように変更する
        # 更に自分が自分のブログにコメントした場合、
        # コメントが来ないように、次の1行を書き加える
        unless @comment.blog.user_id == current_user.id
          Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'comment_created', {message: 'あなたの作成したブログにコメントが付きました'
          })
        end
        # Pusher.trigger('test_channel', 'comment_created', {      message: 'あなたの作成したブログにコメントが付きました'
        # })
        # DIVE19_2_通知機能 で編集 
        # コメントを投稿した際に、トリガーが実行
        # ajaxでヘッダーの数字を書き換える
        Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'notification_created', {
          unread_counts: Notification.where(user_id: @comment.blog.user.id, read: false).count
        })      
      else
        format.html { render :new }
      end
    end
  end
    
  # # DIVE15_コメント機能 で編集
  # # 課題にはないが、編集できるように追加する
  # # 編集するための画面を作らなくてはならないので、やめておく
  # def edit   
  #   # edit, update, destroyで共通コード
  #   set_comment
  # end
  
  # def update
  #   # edit, update, destroyで共通コード
  #   @comment = Comment.find(params[:id])
  #   respond_to do |format|
  #     if @comment.update(comment_params)
  #       redirect_to comments_path, notice: "コメントを更新しました！"
  #       format.js { render :index }
  #     else
  #       render 'edit'
  #       # format.html { render :new }
  #     end
  #   end
  # end

  # DIVE15_コメント機能 で編集
  # 課題　削除機能を追加する
  def destroy
    # edit, update, destroyで共通コード
    set_comment
    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to blog_path(@blog), notice: "コメントを削除しました！"}
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end

  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:blog_id, :content)
    end

    # DIVE15_コメント機能 で編集
    # 課題　削除機能を追加する
    # idをキーとして値を取得するメソッド
    def set_comment
      @comment = Comment.find(params[:id])
    end

end
