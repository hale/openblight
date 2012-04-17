class Hearing < ActiveRecord::Base
	belongs_to :case, :foreign_key => :case_number
end
