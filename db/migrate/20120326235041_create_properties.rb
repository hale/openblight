class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :street
      t.integer :number
      t.integer :zip_code
      
      t.timestamps
    end
  end
end
