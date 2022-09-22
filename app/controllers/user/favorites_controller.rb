class User::FavoritesController < ApplicationController

  def create
    @mutter = Mutter.find(params[:mutter_id])
    mutter = Mutter.find(params[:mutter_id])
    favorite = current_user.favorites.new(mutter_id: mutter.id)
    favorite.save
  end

  def destroy
    @mutter = Mutter.find(params[:mutter_id])
    mutter = Mutter.find(params[:mutter_id])
    favorite = current_user.favorites.find_by(mutter_id: mutter.id)
    favorite.destroy
  end

  def show
    @user = User.find(params[:id])
    @mutters = @user.favorited_mutters.order("created_at DESC").page(params[:page]).per(10)
  end

  private

end