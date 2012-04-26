class AddResetDateToReset < ActiveRecord::Migration
  def change
    add_column :resets, :reset_date, :datetime
  end
end
