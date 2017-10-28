# DIVE19_2_通知機能 で編集  
# デフォルトでは module-end があるだけ
# 間に３行挿入 
module NotificationsHelper
  def posted_time(time)
    time > Date.today ? "#{time_ago_in_words(time)}" : time.strftime('%m月%d日')
  end
end
