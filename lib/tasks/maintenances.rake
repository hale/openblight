require "#{Rails.root}/lib/import_helpers.rb"
require "#{Rails.root}/lib/spreadsheet_helpers.rb"
require "#{Rails.root}/lib/address_helpers.rb"

include ImportHelpers
include SpreadsheetHelpers
include AddressHelpers


namespace :maintenances do
  desc "Downloading files from s3.amazon.com"  
  task :load, [:file_name, :bucket_name] => :environment  do |t, args|
    args.with_defaults(:bucket_name => "neworleansdata", :file_name => "INAP Validated Address Data entry sheet 2012.xlsx")  
    p args

    #connect to amazon
    ImportHelpers.connect_to_aws
    s3obj = AWS::S3::S3Object.find args.file_name, args.bucket_name
    downloaded_file_path = ImportHelpers.download_from_aws(s3obj)

    SpreadsheetHelpers.workbook_to_hash(downloaded_file_path).each do |row|
      unless SpreadsheetHelpers.row_is_empty? row
        Maintenance.create(:house_num => row['Number'], :street_name => row['Street'].upcase, :street_type => AddressHelpers.get_street_type(row['Accessory']),  :address_long =>  AddressHelpers.abbreviate_street_types(row['Address']), :date_recorded => row['Date Recorded'], :date_completed => row['Date Cut'], :program_name => row['Program'])
      end
    end
  end

  desc "Correlate demolition data with addresses"  
  task :match => :environment  do |t, args|
    # go through each demolition
    success = 0
    failure = 0

    Maintenance.find(:all).each do |row|
      # compare each address in demo list to our address table
      #address = Address.where("address_long LIKE ?", "%#{row.address_long}%")

      address = AddressHelpers.find_address(row.address_long)
      unless (address.empty?)
        Maintenance.find(row.id).update_attributes(:address_id => address.first.id)      
        success += 1
      else
        puts "#{row.address_long} address not found in address table"
        failure += 1
      end
    end
    puts "There were #{success} successful matches and #{failure} failed matches"      
  end

  desc "Delete all maintenances from database"
  task :drop => :environment  do |t, args|
    Maintenance.destroy_all
  end
end
