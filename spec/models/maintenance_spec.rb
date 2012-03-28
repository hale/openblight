require 'spec_helper'

describe Maintenance do
	it { should belong_to(:case) }   
end
