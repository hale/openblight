require 'spec_helper'

describe Notification do
  it { should belong_to(:case) }

  it "should not create multiple notifications of the same type for the same case with the same date" do
    time = Time.now
    c = FactoryGirl.build(:case)

    2.times do
      Notification.create(:case_number => c.case_number, :notified => time, :notification_type => "Posting of Notice")
    end

    Notification.count.should eq 1
  end
end
