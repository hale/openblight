require 'spec_helper'

describe Address do
  before do
  	Factory.create(:address)
  end

  it { should validate_uniqueness_of(:address_id) }
  it { should validate_uniqueness_of(:property_id) }
  it { should validate_uniqueness_of(:geopin) }

end
