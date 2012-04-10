class AddressesController < ApplicationController
  respond_to :html, :xml, :json

  def index
    @addresses = Address.page(params[:page]).order(:address_long)

    respond_with(@addresses)
  end

  def show
    @address = Address.find(params[:id])

    respond_with(@address)
  end
  
  def search
    search = params[:address]
    p search
    long_addr_regex = /[1-9]+\s?([a-zA-Z ]+)(st|ave|dr|ct|rd|ln|pl|park|blvd|aly)/i
    if long_addr_regex =~ search
      search = search.upcase
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

    p search
    respond_with(@addresses)
  end
end
