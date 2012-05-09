require 'spec_helper'

describe Hearing do
  it { should belong_to(:case) }

  it "should not create multiple hearings for the same date with the same case" do
    time = Time.now
    c = FactoryGirl.build(:case)

    Hearing.create(:case_number => c.case_number, :hearing_date => time)
    Hearing.create(:case_number => c.case_number, :hearing_date => time)

    Hearing.count.should eq 1
  end
end
