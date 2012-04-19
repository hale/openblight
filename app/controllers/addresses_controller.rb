class AddressesController < ApplicationController
  respond_to :html, :xml, :json
  autocomplete :address, :street_name, :full => true
  
  def index
    @addresses = Address.page(params[:page]).order(:address_long)

    respond_with @addresses
  end

  def show
    @address = Address.find(params[:id])
    @case = Case.find(params[:id])
    @maintenance = Maintenance.where("address_long LIKE ?", "%#{@address.address_long}%")

    respond_with @address, @case, @maintenance
  end
  
  def search
    search = params[:address]
    long_addr_regex = /([0-9]+\s?([a-zA-Z ]+)(st|ave|dr|ct|rd|ln|pl|park|blvd|aly))/i
    long_match = long_addr_regex.match(search)
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

    respond_with(@addresses)
  end
  
  
  def search_by_intersection
    # http://fuzzytolerance.info/finding-street-intersections-in-postgis/
    # SELECT DISTINCT(AsText(intersection(b.point, a.point))) as the_intersection
    # FROM
    # (SELECT point FROM addresses WHERE street_name = 'POYDRAS' LIMIT 1) a,
    # (SELECT point FROM addresses WHERE street_name = 'MAGAZINE') b
    # WHERE a.point && b.point and intersects (b.point, a.point)
    #       
  end
end
