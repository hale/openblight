require "#{Rails.root}/lib/import_helpers.rb"
require 'iconv'

include ImportHelpers

# this class should be generalized
# take in arguments from command line for: Bucket Name, File Name
# maybe also take in a hash of what excel columns should be paired up with in model
# the script should also detect different file formats and use the proper parser

# this script works locally, needs testing in different systems
namespace :inspections do
  desc "Downloading files from s3.amazon.com"  
  task :load => :environment  do |t, args|
    args.with_defaults(:bucket_name => "neworleansdata", :file_name => "HCEB Completed Insp by Inspector.xls")  
    puts args

    #connect to amazon
    ImportHelpers.connect_to_aws
    s3obj = AWS::S3::S3Object.find args.file_name, args.bucket_name
    downloaded_file_path = ImportHelpers.download_from_aws(s3obj)

    label = "Inspector:"  
    #these column names should be should not statically matched
    oo = Excel.new(downloaded_file_path)
    oo.default_sheet = oo.sheets.first
    inspector = nil
    1.upto(oo.last_row) do |row|
      unless (oo.row(row)[0].nil?)
        if oo.row(row)[0] == label then
          inspector = Inspector.find_or_create_by_name(oo.row(row)[3])        #inspector = Inspector.find_by_name(oo.row(row)[3])        
        end
        #puts oo.row(row)
      
        if (oo.row(row)[0].start_with?("HCEB") || oo.row(row)[0].start_with?("CEHB"))
          Inspection.create(:case_number => oo.row(row)[0], :result => oo.row(row)[11],:scheduled_date => oo.row(row)[16], :inspection_date => oo.row(row)[19], :inspection_type => oo.row(row)[21], :inspector_id => inspector.id) 
        end
      end
    end
  end
end
  