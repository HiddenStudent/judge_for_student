class RenameColumnInUser < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :students_answer_id, :studentanswer_id
  end
end
