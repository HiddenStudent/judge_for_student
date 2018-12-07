class RemoveAtaskIdFromTasksGroup < ActiveRecord::Migration[5.1]
  def change
    remove_column :tasks_groups, :atask_id, :integer
  end
end
