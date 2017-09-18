# module ApplicationHelper
# end

# DIVE14_SNSログイン で編集
# SNSログインから取得してきた画像を
# 表示させるヘルパーメソッドを作成する
# 編集する前は ↑ だけの状態これを下記のように編集
module ApplicationHelper
  def profile_img(user)
    
    # carrierwaveでULした画像を表示させる
    return image_tag(user.avatar, alt: user.name) if user.avatar?
       
    unless user.provider.blank?
      img_url = user.image_url
    else
      img_url = 'no_image.png'
    end
    image_tag(img_url, alt: user.name)
  end
end


