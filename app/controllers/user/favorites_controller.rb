class User::FavoritesController < ApplicationController

  def show
    @user = User.find(params[:id])
    @users = @user.favorites
    @mutters = Mutter.where(user_id:@users)
  end

  def create
    mutter = Mutter.find(params[:mutter_id])
    favorite = current_user.favorites.new(mutter_id: mutter.id)
    favorite.save
    redirect_to mutter_path(mutter)
  end

  def destroy
    mutter = Mutter.find(params[:mutter_id])
    favorite = current_user.favorites.find_by(mutter_id: mutter.id)
    favorite.destroy
    redirect_to mutter_path(mutter)
  end

  private

end
