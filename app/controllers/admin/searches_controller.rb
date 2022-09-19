class Admin::SearchesController < ApplicationController

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "つぶやき"
      @mutters = Mutter.looks(params[:search], params[:word])
    elsif @range == "コメント"
      @comments = Comment.looks(params[:search], params[:word])
    else
      @users = User.looks(params[:search], params[:word])
    end
  end

end