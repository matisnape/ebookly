class AddIndexToBooks < ActiveRecord::Migration[5.2]
  def change
    add_index :books, :author_id
    add_index :books, :shop_id
  end
end
