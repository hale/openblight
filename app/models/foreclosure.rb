class Foreclosure < ActiveRecord::Base
	belongs_to :case, :foreign_key => :case_number, :primary_key => :case_number

  def date
    self.sale_date
  end
end
