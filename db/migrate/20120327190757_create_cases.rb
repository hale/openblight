class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|

	    t.string :case_number
      t.integer :geopin

      t.timestamps
    end
    
    add_foreign_key(:cases, :addresses, :column => :geopin)
  end
end
