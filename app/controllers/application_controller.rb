class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :handle_cookies
  private
    def handle_cookies
      @agree_to_legal_disclaimer = !cookies[:agree_to_legal_disclaimer].nil?
    end


end

