require "spec_helper"
require "#{Rails.root}/lib/address_helpers.rb"
include AddressHelpers

describe AddressHelpers do

  context "test address parsing methods" do
    before do
      @full_street_address = "100 Hello Street" 
      @full_avenue_address =  "100 Hello Avenue" 
      @abbr_street_address =  "100 Hello St" 
      @abbr_avenue_address =  "100 HELLO AVE" 
      @full_south_direction_address =  "South 100 Hello Ave" 
      @abbr_s_direction_address =  "S 100 HELLO AVE" 
      @full_east_direction_address =  "East 100 Hello Ave" 
      @abbr_e_direction_address =  "E 100 Hello Ave" 
      @no_street_type =  "100 Hello" 
      @multiple_street_types =  "100 South Street Avenue" 
      @blank_address =  "" 
      @only_numbers =  "1234" 
      @only_park_street_type =  "Place" 
      @only_avenue_street_type =  "Avenue" 
      @street_type_typo =  "Aenue" 
      @real_house_st =  "1019 CHARBONNET ST" 
      @real_house_ambiguous =  "1019 CHARBONNET"
    end

    describe "abbreviate_street_types" do
      it "abbreviates street types" do
        AddressHelpers.abbreviate_street_types(@full_street_address).should eq "100 HELLO ST"
      end
      it "does not filter out other address types" do
        AddressHelpers.abbreviate_street_types(@multiple_street_types).should eq "100 SOUTH STREET AVE"
      end
      it "works with different kinds of street types" do
        AddressHelpers.abbreviate_street_types(@full_avenue_address).should eq "100 HELLO AVE"
      end
      it "does not return a street type if the argument does not have one" do
        AddressHelpers.abbreviate_street_types(@no_street_type).should eq "100 HELLO"
      end
    end

    describe "unabbreviate_street_types" do
      it "does not abbreviate street type" do
        AddressHelpers.unabbreviate_street_types(@full_street_address).should eq "100 HELLO STREET"
      end
      it "does not filter out other address types" do
        AddressHelpers.unabbreviate_street_types(@multiple_street_types).should eq "100 SOUTH STREET AVENUE"
      end
      it "works with different kinds of street types" do
        AddressHelpers.unabbreviate_street_types(@full_avenue_address).should eq "100 HELLO AVENUE"
      end
      it "does not return a street type if the argument does not have one" do
        AddressHelpers.unabbreviate_street_types(@no_street_type).should eq "100 HELLO"
      end
    end

    describe "find_address" do
      it "should not abbreviate street type" do
        address = FactoryGirl.create(:address)
        AddressHelpers.find_address(@real_house_st).should eq([address])
      end
      it "should abbreviate south but nothing else" do
        address = FactoryGirl.create(:address, :address_long => @abbr_s_direction_address)
        AddressHelpers.find_address(@full_south_direction_address).should eq([address])
      end
      it "should abbreviate street types" do
        address = FactoryGirl.create(:address, :address_long => @abbr_avenue_address)
        AddressHelpers.find_address(@full_avenue_address).should eq([address])
      end
      it "returns an empty array if passed an address with an ambiguous street type" do
        AddressHelpers.find_address(@real_house_ambiguous).should eq([])
      end
    end


  end
end
