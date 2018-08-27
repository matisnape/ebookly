class AddIndexToSlugInShops < ActiveRecord::Migration[5.2]
  def change
    add_index :shops, :slug
  end
end
