class Hearing < ActiveRecord::Base
	belongs_to :case, :foreign_key => :case_number, :primary_key => :case_number
  has_many :notifications, :foreign_key => :case_number
end
