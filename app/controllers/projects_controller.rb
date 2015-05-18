class ProjectsController < ApplicationController
  respond_to :json

  before_action :authenticate_user!
  before_action :load_project, only: [:update, :destroy]

  authorize_resource

  def index
    respond_with(@projects = current_user.projects, include: {
      tasks: { include: { comments: { include: :attachments } } }
    })
  end

  def create
    respond_with(@project = current_user.projects.create(project_params))
  end

  def update
    @project.update(project_params)
    respond_with @project
  end

  def destroy
    respond_with @project.destroy
  end

  private

  def load_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
