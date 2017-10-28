# DIVE19_1_メッセージ機能 で編集  
# rails g コマンドを実行した後は index と create があるだけ
# $ rails g controller Messages index create
# それに下記ラインを書き加える
class MessagesController < ApplicationController

  # 各アクションに共通の処理の定義
  # いずれのアクションでも「どの会話なのか」の情報を取得する
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end
  
  def index
    # rails g コマンドを実行した後、下記を追加
    @messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end
  
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end
  
    if @messages.last
      if @messages.last.user_id != current_user.id
       @messages.last.read = true
      end
    end
  
    @message = @conversation.messages.build
  
  end

  def create
    # rails g コマンドを実行した後、下記を追加
    @message = @conversation.messages.build(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  # rails g コマンドを実行した後、下記を追加
  private
    def message_params
      params.require(:message).permit(:body, :user_id)
    end
end
