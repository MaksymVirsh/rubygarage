require 'rails_helper'

RSpec.describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should_not be_able_to :manage, :all }
  end

  describe 'for authenticated user' do
    let(:user) { create(:user) }
    let(:other) { create(:user) }
    let(:project_one) { create(:project, user: user) }
    let(:project_two) { create(:project, user: other) }
    let(:task_one) { create(:task, project: project_one) }
    let(:task_two) { create(:task, project: project_two) }
    let(:comment_one) { create(:comment, task: task_one) }
    let(:comment_two) { create(:comment, task: task_two) }

    it { should be_able_to :create, Project }
    it { should be_able_to :read, project_one, user: user }
    it { should_not be_able_to :read, project_two, user: user }
    it { should be_able_to :update, project_one, user: user }
    it { should_not be_able_to :update, project_two, user: user }
    it { should be_able_to :destroy, project_one, user: user }
    it { should_not be_able_to :destroy, project_two, user: user }

    it { should be_able_to :create, Task }
    it { should be_able_to :read, task_one, user: user }
    it { should_not be_able_to :read, task_two, user: user }
    it { should be_able_to :update, task_one, user: user }
    it { should_not be_able_to :update, task_two, user: user }
    it { should be_able_to :destroy, task_one, user: user }
    it { should_not be_able_to :destroy, task_two, user: user }
    it { should be_able_to :done, task_one, user: user }
    it { should_not be_able_to :done, task_two, user: user }
    it { should be_able_to :sort, task_one, user: user }
    it { should_not be_able_to :sort, task_two, user: user }
    it { should be_able_to :deadline, task_one, user: user }
    it { should_not be_able_to :deadline, task_two, user: user }

    it { should be_able_to :create, Comment }
    it { should be_able_to :destroy, comment_one, user: user }
    it { should_not be_able_to :destroy, comment_two, user: user }

    it { should be_able_to :create, Attachment }
  end
end
