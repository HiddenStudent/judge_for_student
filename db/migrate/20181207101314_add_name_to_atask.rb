class AddNameToAtask < ActiveRecord::Migration[5.1]
  def change
    add_column :atasks, :name, :string
  end
end
