require "#{Rails.root}/lib/import_helpers.rb"
require "#{Rails.root}/lib/spreadsheet_helpers.rb"

include ImportHelpers
include SpreadsheetHelpers


namespace :demolitions do
  desc "Downloading files from s3.amazon.com"  
  task :fema => :environment  do |t, args|
    args.with_defaults(:bucket_name => "neworleansdata", :file_name => "FEMA_Demolitions_2012_January.xlsx")  
    Demolition.destroy_all
    ImportHelpers.connect_to_aws
    s3obj = AWS::S3::S3Object.find args.file_name, args.bucket_name
    downloaded_file_path = ImportHelpers.download_from_aws(s3obj)


    SpreadsheetHelpers.workbook_to_hash(downloaded_file_path).each do |row|
      unless SpreadsheetHelpers.row_is_empty? row
        if row['Status Update']  == '12.Demolished' 
          Demolition.create(:house_num => row['Number'], :street_name => row['Street'], :address_long => "#{row['Number']} #{row['Street']}", :date_started => row['Demo Start'], :date_completed => row['Demo Complete'], :program_name => "NORA")
        end
      end
    end
  end
end


namespace :demolitions do
  desc "Downloading files from s3.amazon.com"  
  task :nora => :environment  do |t, args|
    args.with_defaults(:bucket_name => "neworleansdata", :file_name => "NORA Validated_Demo_DataEntry_2012.xlsx")  
    Demolition.destroy_all
    ImportHelpers.connect_to_aws
    s3obj = AWS::S3::S3Object.find args.file_name, args.bucket_name
    downloaded_file_path = ImportHelpers.download_from_aws(s3obj)

    SpreadsheetHelpers.workbook_to_hash(downloaded_file_path).each do |row|
      unless SpreadsheetHelpers.row_is_empty? row
        Demolition.create(:house_num => row['Number'], :street_name => row['Street'], :address_long =>  row['Address'], :date_started => row['Demo Start'], :date_completed => row['Demo Complete'], :program_name => "NORA")
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


