class RenameStudentAnswer < ActiveRecord::Migration[5.1]
  def change
    rename_table :student_answers, :answers
  end
end
