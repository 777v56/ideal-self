class User::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit, :destroy]

  def create
    @mutter = Mutter.find(params[:mutter_id])
    @comment = Comment.new
    comment = current_user.comments.new(comment_params)
    comment.mutter_id = @mutter.id
    comment.save
  end

  def destroy
    @mutter = Mutter.find(params[:mutter_id])
    @comment = Comment.new
    Comment.find(params[:id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :comment_image)
  end

  def ensure_correct_user
    comment = Comment.find(params[:id])
    unless comment.user == current_user
    redirect_to user_path(current_user.id), notice:"権限がありません。"
    end
  end

end