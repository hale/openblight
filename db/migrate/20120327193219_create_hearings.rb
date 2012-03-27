class CreateHearings < ActiveRecord::Migration
  def change
    create_table :hearings do |t|
      t.datetime :hearing_date
      t.string :hearing_time
      t.string :hearing_status
      t.boolean :reset_hearing
      t.string :hearing_result

      t.integer :one_time_fine
      t.integer :court_cost
      t.integer :recordation_cost
      t.integer :hearing_fines_owed
      t.integer :daily_fines_owed
      t.integer :fines_paid
      t.datetime :date_paid
      t.integer :amount_still_owed
      t.integer :grace_days
      t.datetime :grace_end

      t.string :case_manager

      t.integer :tax_id
      t.string :case_number
      t.integer :notice_id
      t.integer :inspection_id

      t.timestamps
    end

    add_foreign_key(:hearings, :cases, :column => :case_number)
  end
end
