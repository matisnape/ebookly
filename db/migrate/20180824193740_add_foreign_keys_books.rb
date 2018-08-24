class AddForeignKeysToBooks < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :books, :authors
    add_foreign_key :books, :shops
  end
end
