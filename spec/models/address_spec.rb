require 'spec_helper'

describe Address do
  before(:each) do
    @address = FactoryGirl.create(:address)
  end

  it { should validate_uniqueness_of(:address_id) }
  #it { should validate_uniqueness_of(:parcel_id) }
  #it { should validate_uniqueness_of(:geopin) }
  describe "find_addresses_with_cases_by_street" do
   it "should return array of addreses that havee cases on a street" do
      c = FactoryGirl.create(:case, :address => @address)

      result = Address.find_addresses_with_cases_by_street("CHARBONNET")
      result.count.should > 0
    end
  end

  describe "#workflow_steps" do
    context "no associated workflow steps" do
      it "returns an empty array" do
       @address.workflow_steps.should eq([])
      end
    end

    context "associated workflow steps" do
      before do
        @demo = FactoryGirl.create(:demolition, :address => @address, :date_started => Time.now - 2.days )
        c = FactoryGirl.create(:case, :address => @address)
        @hearing = FactoryGirl.create(:hearing, :case => c, :hearing_date => Time.now - 1.day)
      end

      it "returns all steps" do
        @address.workflow_steps.should include(@demo)
        @address.workflow_steps.should include(@hearing)
      end
    end
  end

  describe "#most_recent_status" do
    context "no status found" do
      it "returns nil" do
        @address.most_recent_status.should eq(nil)
      end
    end

    context "associated workflow steps" do
      before do
        c = FactoryGirl.create(:case, :address => @address)
        @inspection = FactoryGirl.create(:inspection, :case => c)
        @demo = FactoryGirl.create(:demolition, :address => @address, :date_started => Time.now)
      end

      it "returns the last step from both cases and abatement" do
        @address.most_recent_status.should eq(@demo)
      end
    end
  end

  describe "sorted cases" do
    context "no associated cases" do
      it "returns an empty array" do
        @address.sorted_cases.should eq []
      end
    end

    context "associated cases" do
      it "returns an array of all cases sorted by their last workflow step" do
        c1 = FactoryGirl.create(:case, :address => @address)
        inspection = FactoryGirl.create(:inspection, :case => c1, :inspection_date => Time.now)

        c2 = FactoryGirl.create(:case, :address => @address)
        inspection = FactoryGirl.create(:inspection, :case => c2, :inspection_date => Time.now)

        @address.sorted_cases.should eq([c1, c2])
      end
    end
  end
end
