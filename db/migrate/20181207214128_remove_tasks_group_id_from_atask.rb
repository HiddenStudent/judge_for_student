class RemoveTasksGroupIdFromAtask < ActiveRecord::Migration[5.1]
  def change
    remove_column :atasks, :tasks_group_id, :integer
  end
end
