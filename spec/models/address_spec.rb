require 'spec_helper'

describe Address do
  before(:each) do
    FactoryGirl.create(:address)
  end

  it { should validate_uniqueness_of(:address_id) }
  #it { should validate_uniqueness_of(:parcel_id) }
  #it { should validate_uniqueness_of(:geopin) }

end
