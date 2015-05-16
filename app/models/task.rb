class Task < ActiveRecord::Base
  belongs_to :project
  has_many :comments, dependent: :destroy

  acts_as_list scope: :project

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, scope: :project_id }
  validates :project, presence: true
end
