class Address < ActiveRecord::Base
	has_many :cases

	validates_uniqueness_of :address_id
	validates_uniqueness_of :property_id
	validates_uniqueness_of :geopin
end
