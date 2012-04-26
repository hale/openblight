class AddStatusFieldsToForeclosures < ActiveRecord::Migration
  def change
    add_column :foreclosures, :sale_date, :string
    add_column :foreclosures, :status, :string
    add_column :foreclosures, :notes, :string
  end
end
