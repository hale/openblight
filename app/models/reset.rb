class Reset < ActiveRecord::Base
	belongs_to :case, :foreign_key => :case_number, :primary_key => :case_number

end
