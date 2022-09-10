class User::FavoritesController < ApplicationController

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

end
