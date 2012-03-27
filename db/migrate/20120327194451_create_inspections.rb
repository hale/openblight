class CreateInspections < ActiveRecord::Migration
  def change
    create_table :inspections do |t|
      t.string :case_number

      t.string :result
      t.date :scheduled_date
      t.date :inspection_date
      t.string :inspection_type

      t.integer :inspector_id

      t.timestamps
    end

    add_foreign_key(:inspections, :cases, :column => :case_number)
  end
end
