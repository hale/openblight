class AddFullFullStreetNameToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :street_full_name, :string    
  end
end
