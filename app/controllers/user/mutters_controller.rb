class User::MuttersController < ApplicationController

def show
  @mutter = Mutter.find(params[:id])
  @mutter_comment = Comment.new
end

end