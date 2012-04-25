class CaseManager < ActiveRecord::Base
	belongs_to :case, :foreign_key => :case_number, :primary_key => :case_manager
end
