require 'spec_helper'

describe Inspector do
  it { should validate_presence_of(:name) }

  describe "#date" do
    it "returns the inspection date if one exists" do
      inspection = FactoryGirl.create(:inspection, :inspection_date => Time.now - 2.days, :scheduled_date => Time.now - 3.days)
      inspection.date.should eq(inspection.inspection_date)
    end

    it "returns the scheduled date if the inspection hasn't happened yet" do
      inspection = FactoryGirl.create(:inspection, :scheduled_date => Time.now)
      inspection.date.should eq(inspection.scheduled_date)
    end
  end
end
