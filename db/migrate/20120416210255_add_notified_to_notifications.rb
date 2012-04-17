class AddNotifiedToNotifications < ActiveRecord::Migration
  def change
  	add_column :notifications, :case_number, :string
    add_column :notifications, :notified, :datetime
  end
end
