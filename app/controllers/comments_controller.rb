class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @comment.save
  end

  private

  def comment
    @comment ||= if params[:id].present?
                   Comment.find(params[:id])
                 else
                   @commentable.comments.new
                 end
  end

  def comment_params
    params.require(:comment).permit(:description, :commentable_type, :commentable_id).merge(user: current_user)
  end
end
