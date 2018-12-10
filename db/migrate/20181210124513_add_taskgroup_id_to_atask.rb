class AddTaskgroupIdToAtask < ActiveRecord::Migration[5.1]
  def change
    add_column :atasks, :taskgroup_id, :integer

  end
end
