class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.string :news_date
      t.text :content
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_update_at
      t.integer :sequence, :default => 0, :null => false

      t.timestamps
    end
  end
end
