class Inspection < ActiveRecord::Base
  belongs_to :case, :foreign_key => :case_number, :primary_key => :case_number
  belongs_to :inspector

  def date
    self.inspection_date.to_datetime || self.scheduled_date.to_datetime || DateTime.new(0)
  end

  def notes
  	self.result
  end
end
