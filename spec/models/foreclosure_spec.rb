require 'spec_helper'

describe Foreclosure do
  it { should belong_to(:case) }
  it { should belong_to(:address) }
end
