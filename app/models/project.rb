# Project
class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, -> { order 'tasks.position' }, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :user_id }
  validates :user, presence: true
end
