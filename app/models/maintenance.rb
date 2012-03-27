class Maintenance < ActiveRecord::Base
  #this is for abatement programs like INAP
	belongs_to :case
end
