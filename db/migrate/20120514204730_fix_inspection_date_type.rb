class FixInspectionDateType < ActiveRecord::Migration
  def up
    change_column :inspections, :scheduled_date, :datetime
    change_column :inspections, :inspection_date, :datetime
  end

  def down
    change_column :inspections, :scheduled_date, :date
    change_column :inspections, :inspection_date, :date
  end
end
