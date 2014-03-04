class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :sequence, :default => 0, :null => false

      t.timestamps
    end
  end
end
