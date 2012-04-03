require 'aws/s3'
#require 'rubyXL'
#require 'yamler'
require 'roo'


# We are using S3 be sure to set Amazon authentication variables
# > export AMAZON_ACCESS_KEY_ID='abcdefghijklmnop'
# > export AMAZON_SECRET_ACCESS_KEY='1234567891012345'


# this class should be generalized
# take in arguments from command line for: Bucket Name, File Name
# maybe also take in a hash of what excel columns should be paired up with in model
# the script should also detect different file formats and use the proper parser

# this script works locally, needs testing in different systems
namespace :maintenance do
  desc "Download and Import data from Excel files hosted at s3.amazon.com"  
  task :load => :environment  do |t, args|
    settings = YAML.load_file("#{Rails.root}/config/bulkimport.yml")

    #connect to amazon
    AWS::S3::Base.establish_connection!(
      :access_key_id     => ENV['AMAZON_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY']
    )
      
    settings['Models'].each_with_index() do | current, index|  
      
      Object::const_get(current['name']).destroy_all
      
    
      s3obj = AWS::S3::S3Object.find current['filename'], current['bucketname']
      downloaded_file_path = "#{Rails.root}" + '/tmp/cache/' + File.basename(s3obj.path)
      downloaded_file = File.new(downloaded_file_path, "wb")
      downloaded_file.write(s3obj.value)
      downloaded_file.close  
    
      workbook = Excelx.new(downloaded_file_path)
      puts workbook.to_yaml

      #these column names should be should not statically matched
      #workbook = RubyXL::Parser.parse(downloaded_file_path)
      #workbook.worksheets[0].extract_data.each_with_index do |row, index|
        #if index == 1 then
        #   next
        #end
        #Object::const_get(current['name']).create(:house_num => row[1], :street_name => row[2], :street_type => row[3], :address_long => row[4], :program_name => row[5] )
      #end
    end  
  end
end
