class ChangeDataTypeForNotificationNotified < ActiveRecord::Migration
  def up
  	change_table :notifications do |t|
      t.change :notified, :date
  	end
  end

  def down
  	change_table :notifications do |t|
      t.change :notified, :datetime
    end
  end
end
