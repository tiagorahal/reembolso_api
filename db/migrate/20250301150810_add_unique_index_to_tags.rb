class AddUniqueIndexToTags < ActiveRecord::Migration[8.0]
  def change
    remove_index :tags, :nome if index_exists?(:tags, :nome)
    add_index :tags, "LOWER(nome)", unique: true, name: "index_tags_on_lower_nome"
  end
end
