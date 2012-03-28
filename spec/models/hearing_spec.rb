require 'spec_helper'

describe Hearing do
  it { should belong_to(:case) }
end
