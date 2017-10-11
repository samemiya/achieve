class Relationship < ActiveRecord::Base
  # DIVE16_フォロー機能 で編集
  # RelationshipがUserに従属することを定義する
  # rails g で作成した状態は空　下記を追加  
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
