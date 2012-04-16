class AddAddressFieldsToForeclosures < ActiveRecord::Migration
  def change
    add_column :foreclosures, :house_num, :string
    add_column :foreclosures, :street_name, :string
    add_column :foreclosures, :street_type, :string
    add_column :foreclosures, :address_long, :string    
  end
end
