class Maintenance < ActiveRecord::Base
  #this is for abatement programs like INAP
  belongs_to :address

  def date
    self.date_completed || DateTime.new(0)
  end
end
