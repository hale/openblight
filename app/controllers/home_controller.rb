require 'rgeo/geo_json'

class HomeController < ApplicationController
  respond_to :html, :xml, :json
  autocomplete :addresses, :address_long

  def index

    @geojson = '{"type":"Feature","geometry":{"type":"Point","coordinates":[2.5,4.0]},"properties":{"color":"red"}}'
    #feature = RGeo::GeoJSON.decode(str2, :json_parser => :json)
    #hash = RGeo::GeoJSON.encode(feature)
    #hash.to_json

    respond_with @geojson

  end


end
