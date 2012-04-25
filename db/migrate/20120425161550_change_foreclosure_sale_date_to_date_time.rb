class ChangeForeclosureSaleDateToDateTime < ActiveRecord::Migration
  def up
    change_table :foreclosures do |t|
      t.remove :sale_date
      t.datetime :sale_date
    end
  end

  def down
    change_table :foreclosures do |t|
      t.remove :sale_date
      t.string :sale_date
    end
  end
end
