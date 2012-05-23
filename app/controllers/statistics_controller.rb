require "#{Rails.root}/lib/statistic_helpers.rb"
class StatisticsController < ApplicationController
  def index
  	@stat = Statistic.new
  	#@stat = StatisticHelpers.all
  end
end
