require "#{Rails.root}/lib/import_helpers.rb"
include ImportHelpers

namespace :maintenance do
  desc "Downloading files from s3.amazon.com"
  task :load => :environment  do |t, args|
    settings = YAML.load_file("#{Rails.root}/config/bulkimport.yml")
    
    #connect to amazon
    ImportHelpers.connect_to_aws
    
    settings['Models'].each_with_index() do |current, index|  
      
      Object::const_get(current['name']).destroy_all
    
      s3obj = AWS::S3::S3Object.find current['filename'], current['bucketname']
      
      file_path = ImportHelpers.download_from_aws(s3obj)
  
      table_data = workbook_to_hash(file_path)
      
      table_data.each_with_index do |spreadsheet_row, index|        
        row_data = {}
        current['column_map'].each_with_index do |(db_column_name, spreadsheet_column_name),index|
            row_data[db_column_name] = spreadsheet_row[spreadsheet_column_name] rescue nil
        end
        puts "#{row_data}"
        #Object::const_get(current['name']).create(row_data)
      end
    end  
  end
end
