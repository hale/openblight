class CreateStreets < ActiveRecord::Migration
  def change
    create_table :streets do |t|
      t.string :prefix
      t.string :prefix_type
      t.string :name
      t.string :suffix
      t.string :suffix_type
      t.string :full_name
      t.integer :suffix_type
      t.integer :length_numberic
      t.integer :shape_len
      t.geometry :the_geom
      t.timestamps
    end
  end
end
