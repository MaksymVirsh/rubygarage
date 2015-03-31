# TasksController
class TasksController < ApplicationController
  respond_to :json

  before_action :authenticate_user!
  before_action :load_task, only: [:update, :destroy, :done, :sort]

  authorize_resource

  def create
    respond_with(@task = Task.create(task_params))
  end

  def update
    if @task.update(task_params)
      render json: @task, status: :ok
    else
      render json: { errors: @task.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    respond_with @task.destroy
  end

  def done
    @task.update(done: params[:task][:done])
    respond_with @task
  end

  def sort
    @task.set_list_position(params[:position].to_i + 1)
    respond_with @task
  end

  private

  def load_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :project_id)
  end
end
