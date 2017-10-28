# DIVE19_1_メッセージ機能 で編集  
# rails g コマンドを実行した後は belongs_to が２行あるだけ
# $ rails g model Message body:text conversation:references user:references read:boolean
# それに validates 以下のラインを書き加える
class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :conversation_id, :user_id
  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
