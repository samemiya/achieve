class Blog < ActiveRecord::Base
    validates :title, presence: true
    belongs_to :user
    
    # DIVE15_コメント機能 で編集　アソシエーションの追加
    # CommentモデルのAssociationを設定
    has_many :comments, dependent: :destroy
end
