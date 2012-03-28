class Notification < ActiveRecord::Base
	belongs_to :hearing, :foreign_key => :case_number
end
