require 'spec_helper'

describe Case do
  before(:each) do
    @case = FactoryGirl.create(:case)
  end
  it { should have_many(:hearings) }
  it { should have_many(:inspections) }
  it { should have_many(:demolitions) }
#  it { should have_many(:maintenances) }
  it { should have_one(:judgement) }
  it { should have_one(:case_manager) }
  it { should have_one(:foreclosure) }
  it { should have_many(:resets) }

  it { should validate_uniqueness_of(:case_number) }

  describe "#assign_address" do
    it "looks up address by street and house number if they're passed and sets association" do
      @address = FactoryGirl.create(:address)
      @case.assign_address({address_long: "123 PERDIDO ST"})

      @case.address.should eq(@address)
    end

    it "looks up address by geopin and assigns it if only one match is found" do
      @address = FactoryGirl.create(:address, :geopin => 12345678)
      @case.update_attribute(:geopin, 12345678)

      @case.assign_address
      @case.address.should eq(@address)
    end

    it "looks up address by geopin and does not assign it if multiple matches are found" do
      @address1 = FactoryGirl.create(:address, :geopin => 12345678)
      @address2 = FactoryGirl.create(:address, :geopin => 12345678)
      @case.update_attribute(:geopin, 12345678)

      @case.assign_address
      @case.address.should eq(nil)
    end
  end
end
