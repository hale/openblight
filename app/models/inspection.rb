class Inspection < ActiveRecord::Base
  belongs_to :case, :foreign_key => :case_number
  belongs_to :inspector

end
