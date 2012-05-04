class RemoveHearingTimeFromHearings < ActiveRecord::Migration
  def up
  	remove_column :hearings, :hearing_time
  end

  def down
  	add_column :hearings, :hearing_time, :string
  end
end
