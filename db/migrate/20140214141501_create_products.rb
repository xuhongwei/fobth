class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_update_at
      t.text :description
      t.integer :category_id
      t.integer :sequence, :default => 0, :null => false

      t.timestamps
    end
  end
end
