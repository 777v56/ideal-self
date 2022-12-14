class User::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "ユーザー名"
      @users = User.looks(params[:search], params[:word])
    else
      @mutters = Mutter.looks(params[:search], params[:word])
    end
  end

end
