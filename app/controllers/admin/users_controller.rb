class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.order("created_at DESC").page(params[:page]).per(10)
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:is_deleted)
  end

end