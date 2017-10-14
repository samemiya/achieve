class UsersController < ApplicationController
  def index
    # DIVE16_フォロー機能 で編集
    # 下記を挿入　indexメソッドでuserを全て取得する
    @users = User.all
  end

  # DIVE16_フォロー機能 で編集　
  # showアクションを定義
  def show
    # @user = @user.comments.build
    @user = User.find(params[:id])
    # @user = User.all   dame
  end
end
