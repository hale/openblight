class AddAddressIDtoMaintenance < ActiveRecord::Migration
  def up
    add_column :maintenances, :address_id, :integer
  end

  def down
    remove_column :maintenances, :address_id, :integer
  end
end
