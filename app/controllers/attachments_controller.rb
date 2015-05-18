class AttachmentsController < ApplicationController
  respond_to :json

  before_action :authenticate_user!

  authorize_resource

  def create
    if params[:file]
      attachment = Attachment.new(file: params[:file])

      render json: attachment if attachment.save!
    else
      render nothing: true
    end
  end
end
