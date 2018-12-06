class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.integer :teacher_id
      t.integer :group_id
      t.string :name

      t.timestamps
    end
  end
end
