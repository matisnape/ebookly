class AddIndexToCreatedAtInShops < ActiveRecord::Migration[5.2]
  def change
    add_index :shops, :created_at
  end
end
