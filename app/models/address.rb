class Address < ActiveRecord::Base
  has_many :cases
  belongs_to :street

  validates_uniqueness_of :address_id
	#validates_uniqueness_of :parcel_id
  #validates_uniqueness_of :geopin

  self.per_page = 50

  def find_addresses_with_cases_by_street(street_string)
      addresses = Address.joins(:cases).where(:addresses => {:street_name => street_string})
      return addresses
  end
end
