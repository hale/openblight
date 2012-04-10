require "#{Rails.root}/lib/import_helpers.rb"
require 'iconv'

include ImportHelpers

# this class should be generalized
# take in arguments from command line for: Bucket Name, File Name
# maybe also take in a hash of what excel columns should be paired up with in model
# the script should also detect different file formats and use the proper parser

# this script works locally, needs testing in different systems
namespace :hearings do
  desc "Downloading files from s3.amazon.com"  
  task :load => :environment  do |t, args|
    args.with_defaults(:bucket_name => "neworleansdata", :file_name => "HCEB Hearing Docket for Hearing Dates.xls")  
    puts args

    #connect to amazon
    ImportHelpers.connect_to_aws
    s3obj = AWS::S3::S3Object.find args.file_name, args.bucket_name
    downloaded_file_path = ImportHelpers.download_from_aws(s3obj)

    #table = ImportHelpers.workbook_to_hash(downloaded_file_path, 15, 21)
    oo = Excel.new(downloaded_file_path)
    oo.default_sheet = oo.sheets.first
    21.upto(oo.last_row) do |row|
        c = Case.find_or_create_by_case_number(:case_number => oo.row(row)[10], :geopin => oo.row(row)[35])
        m = CaseManager.find_or_create_by_name(:name => oo.row(row)[11],:case_number => oo.row(row)[10])
        Hearing.create(:hearing_date => oo.row(row)[19],:hearing_time => oo.row(row)[20], :hearing_status => oo.row(row)[21], :reset_hearing => oo.row(row)[22].nil?, :one_time_fine => oo.row(row)[25], :court_cost => oo.row(row)[25], :recordation_cost => oo.row(row)[26], :hearing_fines_owed => oo.row(row)[27], :daily_fines_owed => oo.row(row)[28], :fines_paid => oo.row(row)[29], :date_paid => oo.row(row)[30], :amount_still_owed => oo.row(row)[31], :grace_days=> oo.row(row)[32], :grace_end => oo.row(row)[33], :case_manager => m.id, :tax_id => oo.row(row)[34], :case_number => c.case_number)
    end
    # 21.upto(oo.last_row) do |row|
    #   unless (oo.row(row)[0].nil?)
    #     if (oo.row(row)[0].start_with?("HCEB") || oo.row(row)[0].start_with?("CEHB"))
    #       c = Case.find_or_create_by_case_number(:case_number => oo.row(row)[10], :geopin => oo.row(row)[35])
          
    #       Hearing.create(:case_number => c.case_number, :result => oo.row(row)[11],:scheduled_date => oo.row(row)[16], :inspection_date => oo.row(row)[19], :inspection_type => oo.row(row)[21], :inspector_id => inspector.id) 
    #     end
    #   end
    # end
  end
end
  