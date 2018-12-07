class AddTaskIdToStudentsAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :students_answers, :task_id, :integer
  end
end
