require 'rgeo/shapefile'

namespace :addresses do
  desc "Load data.nola.gov addresses into database"
  task :load => :environment do
    shpfile = "#{Rails.root}/lib/assets/NOLA_Addresses_20120309/NOLA_Addresses_20120309.shp"
    RGeo::Shapefile::Reader.open(shpfile) do |file|
      puts "File contains #{file.num_records} records"
      nums = 1..9
      nums.each do |n|
         record = file.get(n).attributes
         Address.create(:address_id => record["ADDRESS_ID"], :geopin => record["GEOPIN"] )
      end
    end
  end
end
