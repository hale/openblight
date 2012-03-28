require 'spec_helper'

describe Judgement do
  it { should belong_to(:case) }
end
