class Notification < ActiveRecord::Base
	belongs_to :case, :foreign_key => :case_number, :primary_key => :case_number
  
  validates_uniqueness_of :notified, :scope => [:case_number, :notification_type]

  def date
    self.notified.to_datetime || DateTime.new(0)
  end

  def notes
  	"Notice of Hearing"
  end

end
