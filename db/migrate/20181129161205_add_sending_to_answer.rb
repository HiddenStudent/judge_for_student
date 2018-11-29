class AddSendingToAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :sending, :boolean, default: false
  end
end
