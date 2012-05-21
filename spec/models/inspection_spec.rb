require 'spec_helper'

describe Inspection do
	it { should belong_to(:inspector) }
	it { should belong_to(:case) }

  it "should not create multiple hearings for the same date with the same case" do
    time = Time.now
    c = FactoryGirl.build(:case)

    Inspection.create(:case_number => c.case_number, :scheduled_date => time)
    Inspection.create(:case_number => c.case_number, :scheduled_date => time)

    Inspection.count.should eq 1
  end
end
