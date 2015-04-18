class AddDeadlineToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :deadline, :timestamp
  end
end
