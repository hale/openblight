class Address < ActiveRecord::Base
  has_many :cases
  belongs_to :street

  validates_uniqueness_of :address_id
	#validates_uniqueness_of :parcel_id
  #validates_uniqueness_of :geopin

  self.per_page = 50
end
