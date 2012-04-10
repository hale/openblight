class AddAddressFieldsToDemolition < ActiveRecord::Migration
  def change    
    add_column :demolitions, :address_id, :integer
    add_column :demolitions, :house_num, :string
    add_column :demolitions, :street_name, :string
    add_column :demolitions, :street_type, :string
    add_column :demolitions, :address_long, :string
    add_column :demolitions, :zip_code, :string    
    add_column :demolitions, :program_name, :string
    add_column :demolitions, :date_started, :datetime
    add_column :demolitions, :date_completed, :datetime
  end
end
