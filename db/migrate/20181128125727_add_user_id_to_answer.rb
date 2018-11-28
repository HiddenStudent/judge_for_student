class AddUserIdToAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :user_id, :integer
    add_column :answers, :task_id, :integer
  end
end
