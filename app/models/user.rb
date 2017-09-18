class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # DIVE14_SNSログイン で編集
  # :omniauthableを有効にすることで認証機能を利用できるようにする
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable
  
  # DIVE14_SNSログイン で編集
  # carrierwave用の設定
  mount_uploader :avatar, AvatarUploader #deviseの設定配下に追記
  
  has_many :blogs

  # find_for_facebook_oauthメソッドの定義
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    unless user
      user = User.new(
          # facebook の場合
          name:     auth.extra.raw_info.name,
          provider: auth.provider,
          uid:      auth.uid,
          email:    auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
          image_url:   auth.info.image,
          password: Devise.friendly_token[0, 20]
      )
      user.skip_confirmation!
      user.save(validate: false)
      # user.save
    end
    user
  end

  # find_for_twitter_oauthメソッドの定義
  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    unless user
      user = User.new(
          # twitter の場合
          # name:     auth.extra.raw_info.name,
          name:     auth.info.nickname,
          image_url:   auth.info.image,
          provider: auth.provider,
          uid:      auth.uid,
          email:    auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
          password: Devise.friendly_token[0, 20]
      )
      user.skip_confirmation!
      # user.save(validate: false)
      user.save
    end
    user
  end

# ランダムなuidを作成する
  def self.create_unique_string
    SecureRandom.uuid
  end

# DIVE14_SNSログイン で編集
# omniauthでサインアップしたアカウントのユーザ情報を変更出来るようにする
  def update_with_password(params, *options)
    if provider.blank?
      super
    else
      params.delete :current_password
      update_without_password(params, *options)
    end
  end
  
end
