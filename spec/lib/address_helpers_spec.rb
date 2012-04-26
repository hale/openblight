require "spec_helper"
require "#{Rails.root}/lib/address_helpers.rb"
include AddressHelpers


  
# abbreviate_street_direction
# abbreviate_street_direction
# unabbreviate_street_direction
# get_street_type
# get_street_name
# find_street
# strip_address_number
# strip_address_unit
# find_address



describe AddressHelpers do

  context "associated workflow steps" do
    before do
      @full_street_address = "100 Hello Street"
      @full_avenue_address = "100 Hello Avenue"
      @abbr_street_address = "100 Hello St"
      @abbr_avenue_address = "100 Hello Ave"
      @full_south_direction_address = "South 100 Hello Ave"
      @abbr_s_direction_address = "S 100 Hello Ave"
      @full_east_direction_address = "East 100 Hello Ave"
      @abbr_e_direction_address = "E 100 Hello Ave"
      @no_street_type = "100 Hello"
      @multiple_street_types = "100 South Street Avenue"
      @blank_address = ""
      @only_numbers = "1234"
      @only_park_street_type = "Place"
      @only_avenue_street_type = "Avenue"
      @street_type_typo = "Aenue"

      @real_house_st = "1019 CHARBONNET ST"
      @real_house_ambiguous = "1019 CHARBONNET"
    end
  end
  
  
  describe "abbreviate_street_types" do
    context "abbreviate_street_types" do
    	it "should abbreviate street types" do
        AddressHelpers.abbreviate_street_types(@full_street_address).should eq "100 HELLO ST"
    	end
    	it "should abbreviate street types but not filter out other address types" do
        AddressHelpers.abbreviate_street_types(@multiple_street_types).should eq "SOUTH HELLO AVE"
    	end
    	it "should abbreviate street types" do
        AddressHelpers.abbreviate_street_types(@full_avenue_address).should eq "100 HELLO AVE"
    	end
    	it "abbreviate street is not provided and should remain ambigious" do
        AddressHelpers.abbreviate_street_types(@no_street_type).should eq "100 HELLO"
    	end      
    end
  end




end
