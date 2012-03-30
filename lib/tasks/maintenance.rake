require 'aws/s3'
require 'rubyXL'

# We are using S3 be sure to set Amazon authentication variables
#
# > export AMAZON_ACCESS_KEY_ID='abcdefghijklmnop'
# > export AMAZON_SECRET_ACCESS_KEY='1234567891012345'



namespace :maintenance do
  desc "Downloading files from s3.amazon.com"  
  task :load => :environment do

  AWS::S3::Base.establish_connection!(
    :access_key_id     => ENV['AMAZON_ACCESS_KEY_ID'],
    :secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY']
  )

  maintainance = AWS::S3::S3Object.find 'INAP Validated Address Data entry sheet 2012.xlsx', 'neworleansdata'  

  downloaded_file_path = "#{Rails.root}" + '/tmp/cache/' + File.basename(maintainance.path)
  downloaded_file = File.new(downloaded_file_path, "wb")
  downloaded_file.write(maintainance.value)
  downloaded_file.close  
  
  workbook = RubyXL::Parser.parse(downloaded_file_path)

  workbook.worksheets[0].extract_data.each(1) do |row|
    Maintenance.create(:house_num => row[1], :street_name => row[2], :street_type => row[3], :address_long => row[4], :program_name => row[5] )
  end
  
  end
end
