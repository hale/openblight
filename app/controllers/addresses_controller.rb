require "#{Rails.root}/lib/address_helpers.rb"
include AddressHelpers

class AddressesController < ApplicationController
  respond_to :html, :xml, :json

  autocomplete :address, :address_long

  def index
    @addresses = Address.page(params[:page]).order(:address_long)

    respond_with(@addresses)
  end

  def show
    @address = Address.find(params[:id])

    respond_with(@address)
  end

  def search
    search_term = params[:address]
    Search.create(:term => search_term, :ip => request.remote_ip)
    address_result = AddressHelpers.find_address(params[:address])

    # When user searches they get a direct hit!
    if address_result.length == 1
      # TODO: if json, then we should not redirect.
      redirect_to :action => "show", :id => address_result.first.id
    else
      # if it's not a direct hit, then we look at the street name and just present a list of properties
      # with that street name that have a case. No point in printing out a bunch of houses without cases
      street_name = AddressHelpers.get_street_name(search_term)
      @addresses = Address.find_addresses_with_cases_by_street(street_name).page(params[:page]).order(:house_num)

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @addresses }
        format.json { render :json => @addresses.to_json(:methods => [:most_recent_status_preview]) }
      end
    end
  end

end
