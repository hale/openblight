class Inspection < ActiveRecord::Base
	belongs_to :case
  has_one :inspector
end
