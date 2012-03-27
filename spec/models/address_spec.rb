require 'spec_helper'

describe Address do
  it { should validate_uniqueness_of(:address_id) }
  it { should validate_uniqueness_of(:property_id) }
  it { should validate_uniqueness_of(:geopin) }

end
