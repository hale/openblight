class ChangeAddressKeysOnCase < ActiveRecord::Migration
  def change
    remove_column :cases, :geopin
    add_column :cases, :address_id, :integer
  end
end
