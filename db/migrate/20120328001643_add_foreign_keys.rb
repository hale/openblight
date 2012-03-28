class AddForeignKeys < ActiveRecord::Migration
  def up
  	add_foreign_key(:maintenances, :cases, :column => :case_number)
  end

  def down
    remove_foreign_key(:maintenances, :cases, :column => :case_number)
  end
end
