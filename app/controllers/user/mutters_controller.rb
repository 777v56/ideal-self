class User::MuttersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update , :edit, :destroy]

  def index
    @users = User.all
    @user = User.where(mutter_id:@mutter)
    @mutters = Mutter.all.order("created_at DESC").page(params[:page]).per(10)
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
    @mutters = Mutter.where(user_id:@users).order("created_at DESC").page(params[:page]).per(10)
  end

  def create
    @mutter = Mutter.new(mutter_params)
    @mutter.user_id = current_user.id # user_idの情報はフォームからはきていないので、deviseのメソッドを使って「ログインしている自分のid」を代入
    if @mutter.save
      if @mutter.mutter_image.attached?
        tags = Vision.get_image_data(@mutter.mutter_image)
        tags.each do |tag|
        @mutter.tags.create(name: tag)
        end
      end
      flash[:notice] = "投稿しました。"
      redirect_back(fallback_location: user_path(current_user.id))
    else
      flash[:alert] = "投稿に失敗しました。"
      redirect_back(fallback_location: user_path(current_user.id))
    end
  end

  def edit
    @user = current_user
    @mutter = Mutter.find(params[:id])
  end

  def update
    @mutter = Mutter.find(params[:id])
    @mutter.user_id = current_user.id # user_idの情報はフォームからはきていないので、deviseのメソッドを使って「ログインしている自分のid」を代入
    @mutter.update(mutter_params)
    if @mutter.mutter_image.attached?
      tags = Vision.get_image_data(@mutter.mutter_image)
      tags.each do |tag|
      @mutter.tags.create(name: tag)
      end
    end
    redirect_to user_path(current_user.id), notice: "更新しました。"
  end

  def destroy
  @mutter = Mutter.find(params[:id])
  @mutter.destroy
  flash[:notice] = "削除しました。"
  redirect_back(fallback_location: root_path)
  end

  private

  def mutter_params
  params.require(:mutter).permit(:mutter, :mutter_image)
  end

  def ensure_correct_user
  mutter = Mutter.find(params[:id])
  unless mutter.user == current_user
    redirect_to user_path(current_user.id), notice: "権限がありません。"
  end
  end

end