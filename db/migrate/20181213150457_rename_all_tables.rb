class RenameAllTables < ActiveRecord::Migration[5.1]
  def change
    rename_table :studentanswers, :student_answers
    rename_table :taskgroups, :task_groups
  end
end
