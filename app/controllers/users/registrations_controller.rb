# DIVE14_SNSログイン で編集

# class Users::RegistrationsController < ApplicationController
# end

# ↑ rails g コマンドを実行した状態のもの
# 下記のように編集する
class Users::RegistrationsController < Devise::RegistrationsController
  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end
end