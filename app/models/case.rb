class Case < ActiveRecord::Base
	belongs_to :address
	
	has_many :hearings
	has_many :inspections
	has_many :demolitions #this might be has_one but we are playing it safe in case demolition is rescheduled
	has_many :maintenances
    has_one  :judgement
    has_one  :case_manager
    has_one  :foreclosure
    has_many :resets

end
