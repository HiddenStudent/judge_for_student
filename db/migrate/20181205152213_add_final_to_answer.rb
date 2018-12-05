class AddFinalToAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :final, :boolean, default: false
  end
end
