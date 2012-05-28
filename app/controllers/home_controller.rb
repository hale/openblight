require 'rgeo/geo_json'

class HomeController < ApplicationController
  respond_to :html, :xml, :json
  autocomplete :addresses, :address_long

  def index


  end


end
