# DIVE14_SNSログイン で編集

# class Users::OmniauthCallbacksController < ApplicationController
# end

# ↑ rails s コマンドを使った状態のもの
# これを下のように書き換える

# Facebookログイン用のメソッド
# class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
#   def facebook
#   end
# end

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # facebookメソッドの処理
  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  # twitterメソッドの処理
  def twitter
    # You need to implement the method below in your model
    @user = User.find_for_twitter_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      set_flash_message(:notice, :success, kind: "Twitter") if is_navigational_format?
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end

end