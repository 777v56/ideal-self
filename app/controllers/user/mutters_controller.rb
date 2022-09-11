class User::MuttersController < ApplicationController
 before_action :authenticate_user!

 def index
  @users = User.all
  @mutters = Mutter.all
 end

 def show
  @mutters = current_user.mutters
  @comment = Comment.new
 end

 def timeline
  @users = current_user.followings
  @mutters = Mutter.where(user_id:@users)
 end

 def create
  @mutter = Mutter.new(mutter_params)
  @mutter.user_id = current_user.id # user_idの情報はフォームからはきていないので、deviseのメソッドを使って「ログインしている自分のid」を代入
  @mutter.save
  redirect_to user_path(current_userid)
 end

 private

 def mutter_params
  params.require(:mutter).permit(:mutter)
 end

end