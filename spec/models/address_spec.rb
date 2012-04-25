require 'spec_helper'

describe Address do
  before(:each) do
    FactoryGirl.create(:address)
  end

  it { should validate_uniqueness_of(:address_id) }
  #it { should validate_uniqueness_of(:parcel_id) }
  #it { should validate_uniqueness_of(:geopin) }
  describe "find_addresses_with_cases_by_street" do
  	it "should return array of addreses that havee cases on a street" do
  		result = Address.new
  		result = result.find_addresses_with_cases_by_street("BENTON")
  		result.count.should > 0
  	end
  end

end
