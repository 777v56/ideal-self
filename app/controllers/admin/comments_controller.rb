class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
    @comment = Comment.new
    @user = User.where(comment_id:@comment)
    @comments = Comment.order("created_at DESC").page(params[:page]).per(10)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_comments_path, notice: "削除しました。"
  end

  private
end
