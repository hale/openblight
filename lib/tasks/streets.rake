require 'rgeo/shapefile'

namespace :streets do
  desc "Load streets from data.nola.gov addresses into database"
  task :load => :environment do
    Street.destroy_all
    shpfile = "#{Rails.root}/lib/assets/NOLA_Streets_20120405/NOLA_Streets_20120405_wgs84.shp"


    RGeo::Shapefile::Reader.open(shpfile, {:srid => -1}) do |file|
      puts "File contains #{file.num_records} records"
      nums = 1..file.num_records
      nums.each do |n|
         record = file.get(n).attributes
         begin
           street = Street.find_or_create_by_the_geom( :prefix_direction => record["PREFIX_DIR"], :prefix_type => record["PREFIX_TYP"], :name => record["ST_NAME"], :suffix_direction => record["SUFFIX_DIR"], :suffix_type => record["SUFFIX_TYP"], :full_name => record["NAME"], :shape_len => record["LENGTH"], :the_geom => file.get(n).geometry)         
           status = Address.find_by_street_full_name(record["NAME"]).update_attributes(:street_id => street.id)      
         rescue Exception=>e
           puts "exception #{e.inspect}"
         end         
      end
    end
    
  end
end

namespace :streets do
  desc "Empty streets table"  
  task :drop => :environment  do |t, args|
    Street.destroy_all
  end
end


