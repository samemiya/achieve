class NotificationsController < ApplicationController
  # DIVE19_2_通知機能 で編集  
  # rails g controller コマンドを実行した後は def index があるだけ
  # $ rails g controller notifications index 
  # それを以下のように書き換える
  # order(created_at: :desc) は新しい通知順に並べるコマンド
  before_action :authenticate_user!

  def index
    # DIVE19_2_通知機能 で編集  
    # 未読の通知のみ表示させる
    @notifications = Notification.where(user_id: current_user.id).where(read: false).order(created_at: :desc)
  end
  
  # def index
  # end
end
