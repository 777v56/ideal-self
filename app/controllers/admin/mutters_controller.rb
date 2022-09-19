class Admin::MuttersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
    @mutter = Mutter.new
    @user = User.where(mutter_id:@mutter)
    @mutters = Mutter.order("created_at DESC").page(params[:page]).per(10)
  end

  def destroy
    @mutter = Mutter.find(params[:id])
    @mutter.destroy
    redirect_back(fallback_location: root_path)
  end

  private

end