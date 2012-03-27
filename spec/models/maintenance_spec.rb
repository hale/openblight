require 'spec_helper'

describe Maintenance do
  
  it { should validate_presence_of(:house_num) }
  it { should validate_presence_of(:street_name) }
  it { should validate_presence_of(:street_type) }
  it { should validate_presence_of(:address_long) }
    
end
