require 'spec_helper'

describe Demolition do
  it { should belong_to(:case) }
  it { should belong_to(:address) }
  
end
