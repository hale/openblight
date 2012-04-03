class HomeController < ApplicationController
  def index
    @addresses= Address.all
  end
end
