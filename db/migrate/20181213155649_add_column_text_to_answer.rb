class AddColumnTextToAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :text, :string
  end
end
