class AddSlugToProduct < ActiveRecord::Migration
  def change
    add_column :products, :slug, :string, unique: true
  end
end
