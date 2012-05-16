class Street < ActiveRecord::Base
	has_many :address

  def self.find_like(name)
    Street.where("name LIKE ?", "%#{name}%")
  end
end
