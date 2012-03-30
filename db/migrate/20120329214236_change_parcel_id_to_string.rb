class ChangeParcelIdToString < ActiveRecord::Migration
  def up
    remove_column :addresses, :parcel_id
    add_column :addresses, :parcel_id, :string
    add_column :addresses, :official, :boolean
  end

  def down
    remove_column :addresses, :parcel_id
    add_column :addresses, :parcel_id, :integer
    remove_column :addresses, :official
  end
end
