class User::UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update , :edit]
  before_action :authenticate_user!

  def index
    @users = User.all.order("created_at DESC").page(params[:page]).per(10)
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
      redirect_back(fallback_location: user_path(current_user.id))
      flash[:notice] = "更新しました"
    else
      render edit_user_path(current_user.id)
      flash[:alert] = "更新に失敗しました"
    end
  end

  def withdrawal
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
    flash[:notice] = "退会しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :gender, :birthday, :height, :introduction, :profile_image, :is_deleted)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user.id)
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to mutters_path , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end