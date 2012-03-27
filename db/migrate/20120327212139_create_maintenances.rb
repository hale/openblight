class CreateMaintenances < ActiveRecord::Migration
  def change
    create_table :maintenances do |t|
#      t.string :case_number
#      t.string :case_id
      t.string :house_num
      t.string :street_name
      t.string :street_type
      t.string :address_long
      
      t.string :program_name
      t.datetime :date_recorded
      t.datetime :date_completed
      t.datetime :status
      
      t.timestamps
    end
  end
end
