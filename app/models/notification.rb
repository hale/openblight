class Notification < ActiveRecord::Base
	belongs_to :case, :foreign_key => :case_number, :primary_key => :case_number

  def date
    self.notified || DateTime.new(0)
  end

  def notes
  	""
  end

end
