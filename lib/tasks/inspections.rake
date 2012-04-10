require 'aws/s3'
require 'roo'
require 'iconv'

# We are using S3 be sure to set Amazon authentication variables
# > export AMAZON_ACCESS_KEY_ID='abcdefghijklmnop'
# > export AMAZON_SECRET_ACCESS_KEY='1234567891012345'


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
    AWS::S3::Base.establish_connection!(
      :access_key_id     => ENV['AMAZON_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY']
    )

    puts "Please specify a bucket name:"
    AWS::S3::Service.buckets.each() do |bucket|
      puts "1) #{bucket.name}"
      
      puts "Please specify a file name:"
      bucket.objects(bucket.name).each_with_index do |item, index| 
        puts "#{index}) #{item.key}"
      end        
    end

    puts "opening file: " + args.file_name
    s3obj = AWS::S3::S3Object.find args.file_name, args.bucket_name
    puts "downloding file" + args.file_name
    downloaded_file_path = "#{Rails.root}" + '/tmp/cache/' + File.basename(s3obj.path)
    downloaded_file = File.new(downloaded_file_path, "wb")
    downloaded_file.write(s3obj.value)
    downloaded_file.close  
    puts "file copied to: " + downloaded_file_path
    label = "Inspector:"  
    #these column names should be should not statically matched
    oo = Excel.new(downloaded_file_path)
    puts "" + downloaded_file_path + " opened"
    oo.default_sheet = oo.sheets.first
    inspector = nil
    1.upto(oo.last_row) do |row|
      unless (oo.row(row)[0].nil?)
        if oo.row(row)[0] == label then
          inspector = Inspector.find_or_create_by_name(oo.row(row)[3])        #inspector = Inspector.find_by_name(oo.row(row)[3])        
          puts "Inspector id => " + inspector.id.to_s
        end
        #puts oo.row(row)
      
        if (oo.row(row)[0].start_with?("HCEB") || oo.row(row)[0].start_with?("CEHB"))
          Inspection.create(:case_number => oo.row(row)[0], :result => oo.row(row)[11],:scheduled_date => oo.row(row)[16], :inspection_date => oo.row(row)[19], :inspection_type => oo.row(row)[21], :inspector_id => inspector.id)
          puts "row -> " + row.to_s
          puts ":case_number => " + oo.row(row)[0] + ", :result => " + oo.row(row)[11] + ",:scheduled_date => " + oo.row(row)[16].to_s + ", :inspection_date => " + oo.row(row)[19].to_s + ", :inspection_type => " + oo.row(row)[21] + ", :inspector_id => " + inspector.id.to_s
        end
      end
    end
  end
end
  