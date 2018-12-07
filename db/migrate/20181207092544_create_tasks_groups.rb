class CreateTasksGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks_groups do |t|
      t.integer :group_id
      t.integer :task_id

      t.timestamps
    end
  end
end
