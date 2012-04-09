class CreateParcels < ActiveRecord::Migration
  def change
    create_table :parcels do |t|
      t.timestamps
    end
  end
end
