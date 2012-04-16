require 'roo'


module SpreadsheetHelpers
  
  # the roo gem returns some pretty ugly data structures. this function loops through
  # returns a hash of the excel file
  # this hash will allow you access a variable 
  def workbook_to_hash(path_to_file, header_line = 1, start_line = 2)
    if /.xlsx/ =~ path_to_file
      workbook = Excelx.new(path_to_file)
    else
      workbook = Excel.new(path_to_file)
    end
    table_data = []
    column_names = workbook.row(header_line)
    
    # puts "Column names: #{column_names}"
    # we start in the second row to trim headers
    start_line.upto(workbook.last_row) do |row_num|        
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