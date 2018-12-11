class DelColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :task_id, :integer
    remove_column :users, :group_id, :integer

  end
end
