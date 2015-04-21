class Comment < ActiveRecord::Base
  belongs_to :task

  validates :text, presence: true
  validates :task, presence: true
end
