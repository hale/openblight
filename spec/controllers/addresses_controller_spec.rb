require 'spec_helper'

describe AddressesController do

  before do
    @address = FactoryGirl.create(:address)
  end

  describe "GET index" do
    it "assigns all addresses as @address" do
      get :index
      response.should be_success
    end
  end

  describe "GET show" do
    it "assigns the request address as @address" do
      get :show, :id => @address.id
      assigns(:address).should eq(@address)
    end
  end

  describe "GET search" do
    it "matches the full address if it's given" do
      get :search, :address => "CHARBONNET ST"
      response.should be_success            
      fill_in 'main-search-field', :with => 'some text'      
      click_button "Search Address"
      response.should redirect_to('/addresses/85102061')
    end

    it "matches the street name if no number is given" do
      get :search, :address => "CHARBONNET ST"
      assigns(:addresses).should eq([@address])
    end

    it "should return no addresses if none matching are found" do
      get :search, :address => "155 9th St, San Francisco, CA" 
      assigns(:addresses).should eq([])
    end
  end

end
