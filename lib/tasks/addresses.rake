require 'rgeo/shapefile'

# TODO: In order to be re-deployable, assets should not be hard coded. Maybe we 
# can pull from a URL
# endpoint = 'https://data.nola.gov/download/div8-5v7i/application/zip'
# puts "Connecting to #{endpoint}\n";
# request = Typhoeus::Request.new(endpoint)

namespace :addresses do
  desc "Load data.nola.gov addresses into database"
  task :load => :environment do
    Address.where(:official => true).destroy_all
    shpfile = "#{Rails.root}/lib/assets/NOLA_Addresses_20120309_wgs84/NOLA_Addresses_20120309_wgs84.shp"
    dist_shpfile = "#{Rails.root}/lib/assets/NOLA_Council_Districts_wgs84/NOLA_Council_Districts_wgs84.shp"
    districts = {}
    RGeo::Shapefile::Reader.open(dist_shpfile) do |file|
      file.each do |record|
        districts[record.attributes["OBJECTID"]] = {:council_district => record.attributes["COUNCILDIS"], :geom => record.geometry}
      end
    end
    RGeo::Shapefile::Reader.open(shpfile, {:srid => -1}) do |file|
      puts "File contains #{file.num_records} records"
      nums = 1..3000
      nums.each do |n|
         record = file.get(n).attributes
         a = Address.create(:point => file.get(n).geometry, :official => true, :address_id => record["ADDRESS_ID"], :address_long => record["ADDRESS_LA"], :geopin => record["GEOPIN"], :house_num => record["HOUSE_NUMB"], :parcel_id => record["PARCEL_ID"], :status => record["STATUS"], :street_id => record["STREET_ID"], :street_name => record["STREET"], :street_type => record["TYPE"], :x => record["X"], :y => record["Y"] )
         districts.each do |d|
           if d[1][:geom].contains?(a.point)
             a.case_district = d[1][:council_district]
           end
         end
         a.save
      end
    end
  end
end
