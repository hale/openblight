require 'spec_helper'

describe Inspection do
	it { should belong_to(:inspector) }
	it { should belong_to(:case) }
end
