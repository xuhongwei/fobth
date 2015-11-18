class AddSlugToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :slug, :string, unique: true
  end
end
