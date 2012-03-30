require 'rgeo/shapefile'

# TODO: In order to be re-deployable, assets should not be hard coded. Maybe we 
# can pull from a URL
# endpoint = 'https://data.nola.gov/download/div8-5v7i/application/zip'
# puts "Connecting to #{endpoint}\n";
# request = Typhoeus::Request.new(endpoint)

namespace :addresses do
  desc "Load data.nola.gov addresses into database"
  task :load => :environment do
    Address.destroy_all
    shpfile = "#{Rails.root}/lib/assets/NOLA_Addresses_20120309/NOLA_Addresses_20120309.shp"
    RGeo::Shapefile::Reader.open(shpfile, {:srid => -1}) do |file|
      puts "File contains #{file.num_records} records"
      nums = 1..3000
      nums.each do |n|
         record = file.get(n).attributes
         a = Address.create(:point => file.get(n).geometry, :official => true, :address_id => record["ADDRESS_ID"], :address_long => record["ADDRESS_LA"], :geopin => record["GEOPIN"], :house_num => record["HOUSE_NUMB"], :parcel_id => record["PARCEL_ID"], :status => record["STATUS"], :street_id => record["STREET_ID"], :street_name => record["STREET"], :street_type => record["TYPE"], :x => record["X"], :y => record["Y"] )
      end
    end
  end
end
