class AddCaseNumberToCaseManagers < ActiveRecord::Migration
  def change
    add_column :case_managers, :case_number, :string
    add_column :case_managers, :name, :string
    remove_column :case_managers, :case
  end
end
