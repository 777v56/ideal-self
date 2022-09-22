class User::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit]
  before_action :check_guest, only: :withdrawal

  def index
    @users = User.where(is_deleted: false).order("created_at DESC").page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @users = User.all
    @mutters = @user.mutters.order("created_at DESC").page(params[:page]).per(10)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(current_user.id), notice: "変更しました。"
    else
      flash[:alert] = "変更に失敗しました。"
      render :edit
    end
  end

  def withdrawal
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "退会しました。"
  end

  private

  def user_params
    params.require(:user).permit(:name, :gender, :birthday, :height, :introduction, :profile_image, :is_deleted)
  end

  def ensure_correct_user
    user = User.find(params[:id])
    unless user == current_user
      redirect_to user_path(current_user.id), notice: "権限がありません。"
    end
  end

  def check_guest
    if current_user.email == "guest@example.com"
      redirect_to edit, alert: "ゲストユーザーは削除できません。"
    end
  end

end