class RemoveUuidColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :answers, :uuid
    remove_column :atasks, :uuid
    remove_column :groups, :uuid
    remove_column :studentanswers, :uuid
    remove_column :taskgroups, :uuid
    remove_column :users, :uuid

  end
end
