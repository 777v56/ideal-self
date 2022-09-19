class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
    @comment = Comment.new
    @user = User.where(comment_id:@comment)
    @comments = Comment.order("created_at DESC").page(params[:page]).per(10)
  end

  def destroy
    @comment = comment.find(params[:id])
    @comment.destroy
    redirect_to admin_comments_path
  end

  private
end
