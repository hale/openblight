class AddAddressIdToForeclosure < ActiveRecord::Migration
  def change
    add_column :foreclosures, :address_id, :integer
  end
end
