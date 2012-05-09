class Reset < ActiveRecord::Base
	belongs_to :case, :foreign_key => :case_number, :primary_key => :case_number

  validates_uniqueness_of :reset_date, :scope => :case_number

  def date
    self.reset_date || DateTime.new(0)
  end
end
