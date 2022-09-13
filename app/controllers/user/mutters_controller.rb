class User::MuttersController < ApplicationController
 before_action :authenticate_user!

 def index
  @users = User.all
  @mutter = Mutter.new
  @user = User.where(mutter_id:@mutter)
  @mutters = Mutter.all
  @comment = Comment.new
 end

 def show
  @mutters = current_user.mutters
  @mutter = Mutter.find(params[:id])
  @user = @mutter.user
  @comment = Comment.new
 end

 def timeline
  @user = current_user.followings
  @users = current_user.followings.all
  @mutter = Mutter.new
  @mutters = Mutter.where(user_id:@users)
 end

 def create
  @mutter = Mutter.new(mutter_params)
  @mutter.user_id = current_user.id # user_idの情報はフォームからはきていないので、deviseのメソッドを使って「ログインしている自分のid」を代入
  @mutter.save
  redirect_to user_path(current_user.id)
 end

 def edit
  @user = current_user
 end

 def destroy
  @mutter = Mutter.find(params[:id])
  @mutter.destroy
  redirect_to user_path(current_user.id)
  end

 private

 def mutter_params
  params.require(:mutter).permit(:mutter, :mutter_image)
 end

end