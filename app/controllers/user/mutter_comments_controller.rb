class User::MutterCommentsController < ApplicationController

 def create
   mutter = Mutter.find(params[:mutter_id])
   comment = Comment.new(comment_params)
   comment.user_id = current_user.id
   comment.mutter_id = mutter.id
   comment.save
   redirect_to mutter_path(mutter)
 end

 private

 def post_comment_params
   params.require(:comment).permit(:comment)
 end

end