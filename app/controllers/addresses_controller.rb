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
    @c = Case.where("address_id = ?", @address.id)
    @case = nil
    unless @c.first.nil?
      @case = Case.find(@c.first.id)
    end


    @progressbar = '0%'
    unless @case.nil?
      unless @case.inspections.nil?
        @progressbar = '20%'
      end
      unless @case.notifications.nil?
        @progressbar = '40%'
      end
      unless @case.hearings.nil?
        @progressbar = '60%'
      end
      unless @case.judgement.nil?
        @progressbar = '80%'
      end
      # unless @case.resolutions.nil?
      #   @progressbar = '100%'
      # end
    end
  
    
    respond_with(@address, @case, @progressbar)
  end
  
  def search
    search_term = params[:address]
    address_result = AddressHelpers.find_address(params[:address])        

    # When user searches they get a direct hit!
    unless address_result.empty?
      # TODO: if json, then we should not redirect.
      redirect_to :action => "show", :id => address_result.first.id  and return 
    end
    
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
