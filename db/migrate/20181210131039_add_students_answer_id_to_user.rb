class AddStudentsAnswerIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :students_answer_id, :integer
  end
end
