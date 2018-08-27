class AddSlugToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :slug, :string
  end
end
