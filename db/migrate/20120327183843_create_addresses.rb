class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :geopin, :uniqueness => true
      t.integer :address_id
      t.integer :street_id
      t.integer :parcel_id

      t.string :house_num
      t.string :street_name
      t.string :street_type
      t.string :address_long

      t.string :case_district

      t.float :x
      t.float :y

      t.string :status

      t.timestamps
    end
  end
end
