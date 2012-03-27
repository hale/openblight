class Case < ActiveRecord::Base
	belongs_to :address
	
	has_many :hearings
	has_many :inspections
end
