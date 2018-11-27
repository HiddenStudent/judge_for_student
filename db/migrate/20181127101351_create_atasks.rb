class CreateAtasks < ActiveRecord::Migration[5.1]
  def change
    create_table :atasks do |t|
      t.text :content
      t.integer :id_lang

      t.timestamps
    end
  end
end
