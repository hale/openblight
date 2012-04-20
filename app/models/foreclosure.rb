class Foreclosure < ActiveRecord::Base
  belongs_to :address

  def date
    self.sale_date
  end
end
