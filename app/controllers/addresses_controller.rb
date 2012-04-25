require "#{Rails.root}/lib/address_helpers.rb"
include AddressHelpers


class AddressesController < ApplicationController
  respond_to :html, :xml, :json

  def index
    @addresses = Address.page(params[:page]).order(:address_long)

    respond_with(@addresses)
  end

  def show
    @address = Address.find(params[:id])
    @c = Case.where("address_id = ?", @address.id)
    @case = nil
    unless @c.first.nil?
      @case = Case.find(@c.first.id)
    end
    respond_with(@address, @case)
  end
  
  def search
    # TODO: remove all this regex
    # All this should use the address helper functions to do matching
    search = params[:address]
    long_addr_regex = /([0-9]+\s?([a-zA-Z ]+)(st|ave|dr|ct|rd|ln|pl|park|blvd|aly))/i
    long_match = long_addr_regex.match(search)

    address_result = AddressHelpers.find_address(params[:address])        
    unless address_result.empty?
      # direct hit.
      # TODO: if json, then we should not redirect.
      redirect_to :action => "show", :id => address_result.first.id  and return 
    end
    
    if long_match
      search = long_match[1].upcase
      @addresses = Address.where("address_long = ?", search).page(params[:page]).order(:house_num)
    else
      no_num_regex = /([a-zA-Z]+)\s+(st|ave|dr|ct|rd|ln|pl|park|blvd|aly)/i
      match = no_num_regex.match(search)
      if match
        search = match[1].strip
      end
      search.upcase!
      @addresses = Address.where("street_name = ?", search).page(params[:page]).order(:house_num)
      if @addresses.empty?
        @addresses = Address.where("address_long LIKE ?", "%#{search}%").page(params[:page]).order(:house_num)
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @addresses }
      format.json { render :json => @addresses }
    end
  end
end
