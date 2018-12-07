class RemoveGroupIdFromGroup < ActiveRecord::Migration[5.1]
  def change
    remove_column :groups, :group_id, :integer
  end
end
