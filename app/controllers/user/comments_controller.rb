class User::CommentsController < ApplicationController

 def create
  @mutter = Mutter.find(params[:mutter_id])
  @comment = Comment.new
  mutter = Mutter.find(params[:mutter_id])
  comment = current_user.comments.new(comment_params)
  comment.mutter_id = mutter.id
  comment.save
 end

 def destroy
  @mutter = Mutter.find(params[:mutter_id])
  @comment = Comment.new
  Comment.find(params[:id]).destroy
 end

 private

 def comment_params
  params.require(:comment).permit(:comment)
 end

end