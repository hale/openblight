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
end
