require "#{Rails.root}/lib/import_helpers.rb"
require "#{Rails.root}/lib/spreadsheet_helpers.rb"

include ImportHelpers
include SpreadsheetHelpers


namespace :maintenance do
  desc "Downloading files from s3.amazon.com"  
  task :load => :environment  do |t, args|
    args.with_defaults(:bucket_name => "neworleansdata", :file_name => "INAP Validated Address Data entry sheet 2012.xlsx")  
    Maintenance.destroy_all
    #connect to amazon
    ImportHelpers.connect_to_aws
    s3obj = AWS::S3::S3Object.find args.file_name, args.bucket_name
    downloaded_file_path = ImportHelpers.download_from_aws(s3obj)

    SpreadsheetHelpers.workbook_to_hash(downloaded_file_path).each do |row|
      unless SpreadsheetHelpers.row_is_empty? row
        Maintenance.create(:program_name => row['Program'], :house_num => row['Number'], :street_name => "#{row['Street']} #{row['Accessory']}", :address_long =>  row['Address'], :date_recorded => row['Date Recorded'], :date_completed => row['Date Cut'])
      end
    end
  end
end


namespace :maintenance do
  desc "Downloading files from s3.amazon.com"  
  task :drop => :environment  do |t, args|
    Maintenance.destroy_all
  end
end


