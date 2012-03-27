class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :address_id
      t.integer :street_id
      t.integer :parcel_id
      t.integer :geopin

      t.string :house_num
      t.string :street_name
      t.string :street_type
      t.string :address_long

      t.float :x
      t.float :y

      t.string :status

      t.timestamps
    end
  end
end
