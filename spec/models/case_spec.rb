require 'spec_helper'

describe Case do
  before(:each) do
    FactoryGirl.create(:case)
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
  
end
