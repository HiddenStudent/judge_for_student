class DropAnswers < ActiveRecord::Migration[5.1]
  def change
    drop_table :answers
  end
end
