# Task
class Task < ActiveRecord::Base
  belongs_to :project
  acts_as_list scope: :project

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, scope: :project_id }
end
