class AddColumnToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :feedback, :string
  end
end
