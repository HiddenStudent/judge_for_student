class RemoveIdLangFromAtask < ActiveRecord::Migration[5.1]
  def change
    remove_column :atasks, :id_lang, :integer
  end
end
