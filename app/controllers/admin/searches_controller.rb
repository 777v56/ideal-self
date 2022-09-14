class Admin::SearchesController < ApplicationController

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "つぶやき"
      @mutters = Mutter.looks(params[:search], params[:word])
    else
      @comment = Comment.looks(params[:search], params[:word])
    end
  end

end