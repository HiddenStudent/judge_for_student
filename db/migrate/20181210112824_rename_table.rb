class RenameTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :tasks_groups , :taskgroups
  end
end
