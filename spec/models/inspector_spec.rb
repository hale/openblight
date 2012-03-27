require 'spec_helper'

describe Inspector do
  it { should validate_presence_of(:name) }
end
