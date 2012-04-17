class Case < ActiveRecord::Base
  belongs_to :address
	
  has_many :hearings, :foreign_key => :case_number
  has_many :inspections, :foreign_key => :case_number
  has_many :demolitions, :foreign_key => :case_number  #this might be has_one but we are playing it safe in case demolition is rescheduled
  has_one  :judgement, :foreign_key => :case_number
  has_one  :case_manager, :foreign_key => :case_number
  has_one  :foreclosure, :foreign_key => :case_number
  has_many :resets, :foreign_key => :case_number
  has_many :notfications, :foreign_key => :case_number

  validates_uniqueness_of :case_number
  
end
