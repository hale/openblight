class ChangeAddressKeysOnCase < ActiveRecord::Migration
  def change
    add_column :cases, :address_id, :integer
  end
end
