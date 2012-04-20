require "#{Rails.root}/lib/import_helpers.rb"
require "#{Rails.root}/lib/spreadsheet_helpers.rb"

include ImportHelpers
include SpreadsheetHelpers


namespace :demolitions do
  desc "Downloading files from s3.amazon.com"  
  task :fema => :environment  do |t, args|
    args.with_defaults(:bucket_name => "neworleansdata", :file_name => "FEMA Validated_Demo_DataEntry_2012_January.xlsx")  
    ImportHelpers.connect_to_aws
    s3obj = AWS::S3::S3Object.find args.file_name, args.bucket_name
    downloaded_file_path = ImportHelpers.download_from_aws(s3obj)

    SpreadsheetHelpers.workbook_to_hash(downloaded_file_path).each do |row|
      unless SpreadsheetHelpers.row_is_empty? row
        if row['Status Update']  == '12.Demolished'
          Demolition.find_or_create_by_address_long_and_date_completed(:house_num => row['Number'], :street_name => row['Street'].upcase, :address_long => "#{row['Number']} #{row['Street']}".upcase, :date_started => row['Demo Start'], :date_completed => row['Demo Complete'], :program_name => "NORA")
        end
      end
    end
  end
end


namespace :demolitions do
  desc "Downloading files from s3.amazon.com"  
  task :nora => :environment  do |t, args|
    args.with_defaults(:bucket_name => "neworleansdata", :file_name => "NORA Validated_Demo_DataEntry_2012.xlsx")  
    ImportHelpers.connect_to_aws
    s3obj = AWS::S3::S3Object.find args.file_name, args.bucket_name
    downloaded_file_path = ImportHelpers.download_from_aws(s3obj)

    puts SpreadsheetHelpers.workbook_to_hash(downloaded_file_path)
    
    SpreadsheetHelpers.workbook_to_hash(downloaded_file_path).each do |row|
      unless SpreadsheetHelpers.row_is_empty? row
        Demolition.create(:house_num => row['Number'], :street_name => row['Street'].upcase, :address_long =>  row['Address'].upcase, :date_started => row['Demo Start'], :date_completed => row['Demo Complete'], :program_name => "NORA")
      end
    end
  end
end

namespace :demolitions do
  desc "Downloading files from s3.amazon.com"  
  task :nosd => :environment  do |t, args|
    args.with_defaults(:bucket_name => "neworleansdata", :file_name => "NOSD  BlightStat Report  January 2012.xlsx")  
    ImportHelpers.connect_to_aws
    s3obj = AWS::S3::S3Object.find args.file_name, args.bucket_name
    downloaded_file_path = ImportHelpers.download_from_aws(s3obj)

    SpreadsheetHelpers.workbook_to_hash(downloaded_file_path).each do |row|
      unless SpreadsheetHelpers.row_is_empty? row
        #:date_completed => row['Demo Complete'], this throws error. need to format date.
        Demolition.create(:house_num => row['Number'], :street_name => row['Street'].upcase, :address_long =>  row['Address'].upcase, :date_started => row['Demo Start'],  :program_name => "NOSD")
      end
    end
  end
end




namespace :demolitions do
  desc "Downloading files from s3.amazon.com"  
  task :socrata => :environment  do |t, args|

    properties = ImportHelpers.download_json_convert_to_hash('https://data.nola.gov/api/views/abvi-rghr/rows.json?accessType=DOWNLOAD')
    exceptions = []
    properties[:data].each do |row|
      begin
        Demolition.find_or_create_by_address_long_and_date_completed(:house_num => row[16].split(' ')[0], :street_name => row[16].sub(house_num + ' ', '').upcase, :address_long =>  row[16], :date_completed => row[11], :program_name => row[9])
      rescue Exception=>e
        exceptions.push(row);
      end
    end
    
    if exceptions.length
      puts "There are #{exceptions.length} import errors errors"
      exceptions.each do |row|
        puts " OBJECT ID: #{row[2]}"
      end
    end
    
  end
end



namespace :demolitions do
  desc "Correlate demolition data with addresses"  
  task :correlate => :environment  do |t, args|
    Demolition.find(:all).each do |row|
            
      address = Address.where("address_long LIKE ?", "%#{row.address_long}%")
      
      unless(address.empty?)
        Demolition.find(row.id).update_attributes(:address_id => address.first.id)      
      else
        puts "#{row.address_long} address not found"
      end
    end
  end
end


namespace :demolitions do
  desc "Downloading files from s3.amazon.com"  
  task :drop => :environment  do |t, args|
    Demolition.destroy_all
  end
end