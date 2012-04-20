class AddAddressMatchConfidenceColumn < ActiveRecord::Migration
  def change
    add_column :demolitions, :address_match_confidence, :integer
    add_column :maintenances, :address_match_confidence, :integer
    add_column :foreclosures, :address_match_confidence, :integer    
  end
end
