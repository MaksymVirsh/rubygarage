require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:user) { create(:user) }
  let!(:project) { create(:project, user_id: user.id) }

  it { should belong_to :project }
  it { should respond_to :done }
  it { should respond_to :name }
  it { should respond_to :position }
  it { should validate_presence_of :name }
end
