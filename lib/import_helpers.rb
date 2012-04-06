require 'aws/s3'
require 'roo'


module ImportHelpers
  
  # We are using S3 be sure to set Amazon authentication enviroment variables
  # > export AMAZON_ACCESS_KEY_ID='abcdefghijklmnop'
  # > export AMAZON_SECRET_ACCESS_KEY='1234567891012345'
  def connect_to_aws
    AWS::S3::Base.establish_connection!(
      :access_key_id     => ENV['AMAZON_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY']
    )
  end
  
  # take the s3 object and save the contents to local filesystem
  def download_from_aws(s3_obj)
    downloaded_file_path = "#{Rails.root}" + '/tmp/cache/' + File.basename(s3_obj.path)
    downloaded_file = File.new(downloaded_file_path, "wb")
    downloaded_file.write(s3_obj.value)
    downloaded_file.close   
    return downloaded_file_path
  end
  
  # the roo gem returns some pretty ugly data structures. this function loops through
  # returns a hash of the excel file
  # this hash will allow you access a variable 
  def workbook_to_hash(path_to_file)
    workbook = Excelx.new(path_to_file)
    table_data = []
    column_names = workbook.row(1)
    
    puts "#{column_names}"
    # we start in the second row to trim headers
    2.upto(workbook.last_row) do |row_num|        
      row_data = {}
      
      workbook.row(row_num).each_with_index do |cell_data, column_num|        
        column_name = column_names[column_num]
        row_data[column_name] = cell_data        
      end
      
      unless row_is_empty? row_data
        table_data[row_num] = row_data
      end
      
    end
    return table_data    
  end
  
  # loops through each row and if all the cells are empty
  def row_is_empty?(row)
    row.each_with_index do |(label,data),index|
      unless data.nil? || data == ""
        return false
      end
    end
    return true
  end
  
end