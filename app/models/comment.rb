class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog
  # DIVE19_2_通知機能 で編集  
  # rails g コマンドを実行した後は belongs_to が２行あるだけ
  # $ rails g 
  # それに has_many 以下のラインを書き加える
  has_many :notifications, dependent: :destroy
end
