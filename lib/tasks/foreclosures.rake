require "#{Rails.root}/lib/import_helpers.rb"
require "#{Rails.root}/lib/spreadsheet_helpers.rb"

include ImportHelpers
include SpreadsheetHelpers


namespace :foreclosures do
  desc "Downloading files from s3.amazon.com"  
  task :load => :environment  do |t, args|
    args.with_defaults(:bucket_name => "neworleansdata", :file_name => "Sheriff Sale.xlsx")  
    #connect to amazon
    ImportHelpers.connect_to_aws
    s3obj = AWS::S3::S3Object.find args.file_name, args.bucket_name
    downloaded_file_path = ImportHelpers.download_from_aws(s3obj)

    oo = Excelx.new(downloaded_file_path)
    oo.default_sheet = oo.sheets[7]
    38.upto(oo.last_row) do |row|
      unless SpreadsheetHelpers.row_is_empty? oo.row(row) 
        Foreclosure.create(:house_num => oo.row(row)[8], :street_name => oo.row(row)[9], :address_long => "#{oo.row(row)[8]} #{oo.row(row)[9]}".upcase, :notes => oo.row(row)[13], :sale_date => oo.row(row)[14])
      end        
    end 
  end
end

namespace :foreclosures do
  desc "Downloading files from s3.amazon.com"  
  task :drop => :environment  do |t, args|
    Foreclosure.destroy_all
  end
end