class AddColumnsToStudentanswerRename < ActiveRecord::Migration[5.1]
  def change
    add_column :student_answers, :text, :string
    add_column :student_answers, :content, :string
  end
end
