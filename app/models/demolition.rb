class Demolition < ActiveRecord::Base
	belongs_to :case, :foreign_key => :case_number, :primary_key => :case_number

  def date
    self.date_started
  end

end
