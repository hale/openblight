require 'aws/s3'
require 'rubyXL'

# We are using S3 be sure to set Amazon authentication variables
# > export AMAZON_ACCESS_KEY_ID='abcdefghijklmnop'
# > export AMAZON_SECRET_ACCESS_KEY='1234567891012345'


# this class should be generalized
# take in arguments from command line for: Bucket Name, File Name
# maybe also take in a hash of what excel columns should be paired up with in model
# the script should also detect different file formats and use the proper parser

# this script works locally, needs testing in different systems
namespace :maintenance do

  desc "Downloading files from s3.amazon.com"
  task :load => :environment  do |t, args|
    args.with_defaults(:bucket_name => "neworleansdata", :file_name => "INAP Validated Address Data entry sheet 2012.xlsx")  
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

    s3obj = AWS::S3::S3Object.find args.file_name, args.bucket_name

    downloaded_file_path = "#{Rails.root}" + '/tmp/cache/' + File.basename(s3obj.path)
    downloaded_file = File.new(downloaded_file_path, "wb")
    downloaded_file.write(s3obj.value)
    downloaded_file.close  

    #these column names should be should not statically matched
    workbook = RubyXL::Parser.parse(downloaded_file_path)
    workbook.worksheets[0].extract_data.each_with_index do |row, index|
      if index == 1 then
       next
    end
    Maintenance.create(:house_num => row[1], :street_name => row[2], :street_type => row[3], :address_long => row[4], :program_name => row[5] )
  end
  
  end
end
