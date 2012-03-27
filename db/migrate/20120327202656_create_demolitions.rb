class CreateDemolitions < ActiveRecord::Migration
  def change
    create_table :demolitions do |t|
      t.string :case_number


      t.timestamps
    end
    add_foreign_key(:demolitions, :cases, :column => :case_number)
  end
end
