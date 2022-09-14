class User::UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update , :edit]
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.all.order("created_at DESC").page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @users = User.all
    @mutter = Mutter.new
    @mutters = @user.mutters.order("created_at DESC").page(params[:page]).per(10)
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render edit_user_path(current_user.id)
    end
  end

  def edit
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :gender, :birthday, :height, :introduction, :profile_image)
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