class Demolition < ActiveRecord::Base
  belongs_to :address

  def date
    self.date_completed
  end

end
