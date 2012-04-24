require "#{Rails.root}/lib/import_helpers.rb"
require "#{Rails.root}/lib/address_helpers.rb"
require 'iconv'

include ImportHelpers
include AddressHelpers


namespace :hearings do
  desc "Downloading files from s3.amazon.com"  
  task :load => :environment  do |t, args|
        args.with_defaults(:bucket_name => "neworleansdata", :file_name => "HCEB Hearing Docket for Hearing Dates.xls")  
        puts args

        #connect to amazon
        ImportHelpers.connect_to_aws
        s3obj = AWS::S3::S3Object.find args.file_name, args.bucket_name
        downloaded_file_path = ImportHelpers.download_from_aws(s3obj)

        oo = Excel.new(downloaded_file_path)
        oo.default_sheet = oo.sheets.first
        21.upto(oo.last_row) do |row|

            if oo.row(row)[0].nil?
                next
            end

            address = AddressHelpers.find_address(oo.row(row)[0])
            unless address.empty?
              add_id = address.first.id
              c = Case.find_or_create_by_case_number(:case_number => oo.row(row)[10], :geopin => oo.row(row)[35], :address_id => add_id)
            else
              c = Case.find_or_create_by_case_number(:case_number => oo.row(row)[10], :geopin => oo.row(row)[35])
            end
            m = CaseManager.find_or_create_by_name(:name => oo.row(row)[11],:case_number => oo.row(row)[10])
            status = oo.row(row)[21]
            unless status.nil?
                status = status.split(" ")[0].delete(":").downcase
            end

            unless status == "reset" || status.nil?
                j = Judgement.find_or_create_by_case_number_and_status(:case_number => oo.row(row)[10], :status => status, :notes => oo.row(row)[21])
            end

            unless oo.row(row)[22].nil?
                date = oo.row(row)[22].to_s.split("/")
                time = 0
                unless oo.row(row)[23].nil? 
                    time = oo.row(row)[23]
                end
                time = Time.at(time).gmtime.strftime('%R:%S')
                time = time.split(":")

                reset_date = DateTime.new(date[2].to_i,date[0].to_i,date[1].to_i,time[0].to_i,time[1].to_i,time[2].to_i)
                r = Reset.find_or_create_by_case_number_and_reset_date(:case_number => oo.row(row)[10], :reset_date => reset_date)#oo.row(row)[22].to_s + " " + oo.row(row)[23])
            end

            unless oo.row(row)[14].nil?
                n = Notification.find_or_create_by_case_number_and_notified(:case_number => oo.row(row)[10], :notified => oo.row(row)[14])
            end

            Hearing.find_or_create_by_case_number(:case_number => c.case_number, :hearing_date => oo.row(row)[19],:hearing_time => oo.row(row)[20], :hearing_status => status, :reset_hearing => oo.row(row)[22].nil?, :one_time_fine => oo.row(row)[25], :court_cost => oo.row(row)[25], :recordation_cost => oo.row(row)[26], :hearing_fines_owed => oo.row(row)[27], :daily_fines_owed => oo.row(row)[28], :fines_paid => oo.row(row)[29], :date_paid => oo.row(row)[30], :amount_still_owed => oo.row(row)[31], :grace_days=> oo.row(row)[32], :grace_end => oo.row(row)[33], :case_manager => m.id, :tax_id => oo.row(row)[34])
            status = nil
        end
    end

  desc "Delete all cases, case managers, judgements, notifications, and resets from database"
  task :drop => :environment  do |t, args|
        Case.destroy_all
        CaseManager.destroy_all
        Judgement.destroy_all
        Notification.destroy_all
        Reset.destroy_all
  end
end
