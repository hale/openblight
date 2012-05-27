
class StreetsController < ApplicationController
  respond_to :html, :json, :xml	
  autocomplete :street, :full_name

end
