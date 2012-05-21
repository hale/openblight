class AddIndexes < ActiveRecord::Migration
  def up
    add_index :addresses, :address_long
    add_index :addresses, [:house_num, :street_name]
    add_index :cases, :case_number
    add_index :cases, :address_id
    add_index :demolitions, :address_id
    add_index :maintenances, :address_id
    add_index :foreclosures, :address_id
  end

  def down
    remove_index :addresses, :address_long
    remove_index :addresses, [:house_num, :street_name]
    remove_index :cases, :case_number
    remove_index :cases, :address_id
    remove_index :demolitions, :address_id
    remove_index :maintenances, :address_id
    remove_index :foreclosures, :address_id
  end
end
