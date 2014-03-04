class CreateHomes < ActiveRecord::Migration
  def change
    create_table :homes do |t|

      t.string :slide_title
      t.string :slide_url
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_update_at

      t.string :photo_url
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_update_at

      t.timestamps
    end
  end
end
