class CreateResets < ActiveRecord::Migration
  def change
    create_table :resets do |t|
   	  t.string :case_number
      t.timestamps
    end
    add_foreign_key(:resets, :cases, :column => :case_number)
  end
end
