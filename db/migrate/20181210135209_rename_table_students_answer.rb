class RenameTableStudentsAnswer < ActiveRecord::Migration[5.1]
  def change
    rename_table :students_answers , :studentanswers
  end
end
