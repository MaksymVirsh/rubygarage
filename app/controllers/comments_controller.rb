class CommentsController < ApplicationController
  respond_to :json

  before_action :authenticate_user!

  authorize_resource

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      Attachment.where(id: params[:attachments]).update_all(comment_id: @comment.id)
    end

    respond_with @comment
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
