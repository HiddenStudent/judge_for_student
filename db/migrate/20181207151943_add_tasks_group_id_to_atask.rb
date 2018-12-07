class AddTasksGroupIdToAtask < ActiveRecord::Migration[5.1]
  def change
    add_column :atasks, :tasks_group_id, :integer
  end
end
