class DestroyColumnFromAnswers < ActiveRecord::Migration[5.1]
  def change
    remove_column :answers, :answer_id, :integer
  end
end
