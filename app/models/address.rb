class Address < ActiveRecord::Base
  belongs_to :street
  has_many :cases
  has_many :demolitions
  has_many :foreclosures
  has_many :maintenances

  validates_uniqueness_of :address_id
	#validates_uniqueness_of :parcel_id
  #validates_uniqueness_of :geopin

  self.per_page = 50

  def self.find_addresses_with_cases_by_street(street_string)
     Address.joins(:cases).where(:addresses => {:street_name => street_string})
  end
  
  def self.find_addresses_by_geopin(geopin)
  	 Address.where("geopin = ?", geopin)
  end

end
