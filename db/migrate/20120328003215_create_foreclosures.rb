class CreateForeclosures < ActiveRecord::Migration
  def change
    create_table :foreclosures do |t|
    	t.string :case_number
      t.timestamps
    end
    add_foreign_key(:foreclosures, :cases, :column => :case_number)
  end
end
