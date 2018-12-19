class CreateGroupUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :group_users do |t|
      t.integer :group_id
      t.integer :user_id

      t.timestamps
    end
  end
end
