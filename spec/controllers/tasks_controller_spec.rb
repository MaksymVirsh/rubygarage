require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  sign_in_user

  before :each do
    request.headers["accept"] = 'application/json'
  end

  describe 'POST #create' do
    let!(:project) { create(:project, user_id: @user.id) }

    context 'with valid attributes' do
      it 'creates a task' do
        expect do
          post :create, task: attributes_for(:task, project_id: project.id)
        end.to change(Task, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a task' do
        expect do
          post :create, task: attributes_for(:invalid_task, project_id: project.id)
        end.to_not change(Task, :count)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valide attributes' do
      let!(:project) { create(:project, user_id: @user.id) }
      let!(:task) { create(:task, project_id: project.id) }

      it 'updates task' do
        expect do
          patch :update, id: task, task: attributes_for(:task)
        end.to_not change(Task, :count)
      end

      it 'return object json' do
        patch :update, id: task, task: attributes_for(:task)
        expect(response.body.strip).to_not be_empty
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:project) { create(:project, user_id: @user.id) }
    let!(:task) { create(:task, project_id: project.id) }

    it 'deletes task' do
      expect { delete :destroy, id: task }.to change(Task, :count).by(-1)
    end
  end

  describe 'PUT #done' do
    let!(:project) { create(:project, user_id: @user.id) }
    let!(:task) { create(:task, project_id: project.id) }

    it 'mark the task as done' do
      put :done, id: task, task: attributes_for(:task_done)
      task.reload

      expect(task.done).to eq true
    end
  end

  describe 'PUT #sort' do
    let!(:project) { create(:project, user_id: @user.id) }
    let!(:tasks) { create_list(:task, 2, project_id: project.id) }

    it 'change tasks priority' do
      tasks_before = Task.all.order('position').pluck(:id)
      put :sort, id: tasks.first, position: 1
      tasks_after = Task.all.order('position').pluck(:id)

      expect(tasks_after).to eq tasks_before.reverse
    end
  end
end
