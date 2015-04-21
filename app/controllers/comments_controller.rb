class CommentsController < ApplicationController
  respond_to :json

  before_action :authenticate_user!

  authorize_resource

  def create
    respond_with(@comment = Comment.create(comment_params))
  end

  def destroy
    @comment = Comment.find(params[:id])
    respond_with @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :task_id)
  end
end
