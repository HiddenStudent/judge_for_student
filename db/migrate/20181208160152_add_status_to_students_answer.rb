class AddStatusToStudentsAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :students_answers, :status, :string, default: "In process"
  end
end
