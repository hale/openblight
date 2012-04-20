class AddDirectionToStreet < ActiveRecord::Migration
  def change
    add_column :streets, :prefix_direction, :string
    add_column :streets, :suffix_direction, :string    
  end
end
