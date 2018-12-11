class DeleteTrashColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :status, :string
    remove_column :atasks, :group_id, :integer
    remove_column :answers, :user_id, :integer
    remove_column :answers, :task_id, :integer
    remove_column :answers, :sending, :boolean
    remove_column :answers, :final, :boolean
    remove_column :answers, :status, :string
    remove_column :answers, :group_id, :integer



  end
end
