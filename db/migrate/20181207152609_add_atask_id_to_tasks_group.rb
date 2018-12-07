class AddAtaskIdToTasksGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks_groups, :atask_id, :integer
  end
end
