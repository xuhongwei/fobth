class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :name
      t.string :url
      t.integer :sequence, :default => 0, :null => false

      t.timestamps
    end
  end
end
