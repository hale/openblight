class Inspection < ActiveRecord::Base
  belongs_to :case, :foreign_key => :case_number, :primary_key => :case_number
  belongs_to :inspector

  def date
    self.inspection_date || self.scheduled_date
  end

end
