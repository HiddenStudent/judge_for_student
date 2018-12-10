class DropTableGroupInfo < ActiveRecord::Migration[5.1]
  def change
    drop_table :group_infos
  end
end
