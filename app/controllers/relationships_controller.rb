class RelationshipsController < ApplicationController
  # rails g コマンドを入力した時点では、下記のまま
  # それを、以下のように書き替える
  # def create
  # end

  # def destroy
  # end

  # DIVE16_フォロー機能 で編集
  # createメソッドの処理を実装する　
  before_action :authenticate_user!
  respond_to :js

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_with @user
  end
  
  # relationshipsのdestroyメソッドを作成する　
  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_with @user
  end

  # def edit
  #   @user = User.find(params[:relationship][:followed_id])
  #   current_user.follow!(@user)
  #   respond_with @user
  # end

end
