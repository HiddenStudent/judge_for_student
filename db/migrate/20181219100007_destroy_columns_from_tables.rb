class DestroyColumnsFromTables < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :studentanswer_id, :integer
    remove_column :tasks, :taskgroup_id, :integer
  end
end
