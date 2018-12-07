class AddFinalToStudentsAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :students_answers, :final, :boolean, default: false
  end
end
