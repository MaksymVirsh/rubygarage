class AddPositionToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :position, :integer, index: true
  end
end
