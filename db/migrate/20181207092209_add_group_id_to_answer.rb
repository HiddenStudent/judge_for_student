class AddGroupIdToAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :group_id, :integer
  end
end
