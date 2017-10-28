# DIVE19_1_メッセージ機能 で編集  
# rails g コマンドを実行した後は index と create があるだけ
# $ rails g controller Conversations index create
# それに下記ラインを書き加える
class ConversationsController < ApplicationController

  before_action :authenticate_user!

  def index
    # rails g コマンドを実行した後、下記を追加
    @users = User.all  
    @conversations = Conversation.all
  end

  def create
    # rails g コマンドを実行した後、下記を追加
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end

    redirect_to conversation_messages_path(@conversation)

  end

  # rails g コマンドを実行した後、下記を追加
  private
    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end

end
