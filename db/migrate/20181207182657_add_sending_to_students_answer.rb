class AddSendingToStudentsAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :students_answers, :sending, :boolean, default: false
  end
end
