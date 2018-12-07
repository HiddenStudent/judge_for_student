class CreateStudentsAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :students_answers do |t|
      t.integer :user_id
      t.integer :answer_id

      t.timestamps
    end
  end
end
