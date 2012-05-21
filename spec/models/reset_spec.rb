require 'spec_helper'

describe Reset do
  it { should belong_to(:case) }

  it "should not create multiple resets with the same date" do
    time = Time.now
    c = FactoryGirl.build(:case)

    Reset.create(:case_number => c.case_number, :reset_date => time)
    Reset.create(:case_number => c.case_number, :reset_date => time)

    Reset.count.should eq 1
  end
end
