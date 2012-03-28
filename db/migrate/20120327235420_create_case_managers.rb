class CreateCaseManagers < ActiveRecord::Migration
  def change
    create_table :case_managers do |t|
      t.string :case
      t.timestamps
    end
    add_foreign_key(:case_managers, :cases, :column => :case_number)
  end
end
