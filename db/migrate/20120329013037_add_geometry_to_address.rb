class AddGeometryToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :point, :geometry
  end
end
