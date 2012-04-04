class AddressesController < ApplicationController
  def index
    @address = Address.all
  end

  def show
    @address = Address.find(params[:id])
  end
end
