#move this to better spot
class String
  def single_space
    self.split.join(' ')
  end
end

module AddressHelpers

  @street_types = {'ST' => "STREET", 'AVE' => "AVENUE", 'DR'=> 'DRIVE', 'CT'=> "COURT", 'RD'=> 'ROAD', "LN" => 'LANE', 'PL' => 'PLACE', 'PARK' => 'PARK', 'BLVD' => 'BOULEVARD', 'ALY' => 'ALLEY'}
  @street_direction = {'S' => 'SOUTH', 'N' => 'NORTH', 'E' => 'EAST', 'W' => 'WEST'}

  # DRY NOT AT WORK HERE
  # WE SHOULD COMPRESS THESE FUNCTIONS

  def abbreviate_street_types(streetname)
    streetname = streetname.upcase
    @street_types.each do |(value, label)|
      unless streetname.match(/#{label}$/).nil?
        return streetname.sub(/#{label}$/, value)
      end
    end
    return streetname.single_space;
  end

  def unabbreviate_street_types(streetname)
    streetname = streetname.upcase
    @street_types.each do |(label, value)|
      unless streetname.match(/#{label}$/).nil?
        return streetname.sub(/#{label}$/, value)
      end
    end
    return streetname.single_space;
  end
  
  
  def abbreviate_street_direction(streetname)
    streetname = streetname.upcase
    @street_direction.each do |(value, label)|
      unless streetname.match(/#{label}/).nil?
        return streetname.sub(/#{label}/, value)
      end
    end
    return streetname.single_space;
  end
  
  def unabbreviate_street_direction(streetname)
    streetname = streetname.upcase
    @street_direction.each do |(value, label)|
      unless streetname.match(/#{label}/).nil?
        return streetname.sub(/#{label}/, value)
      end
    end
    return streetname.single_space;
  end


  

  def get_street_type(streetname)
    streetname = streetname.upcase
    @street_types.each do |(label, value)|
      if !streetname.match(/#{label}$/).nil? || !streetname.match(/#{value}$/).nil?
        return label
      end
    end
    return streetname.single_space;
  end


  def get_street_name(streetname)
    streetname = streetname.to_s.single_space.upcase
    streetname = strip_address_number(streetname)
    streetname = strip_address_unit(streetname)
    
    unless streetname.nil?
      @street_types.each do |(label, value)|
        unless streetname.match(/#{label}$/).nil?
          return streetname.sub(/#{label}$/, '').single_space
        end
      
        unless streetname.match(/#{value}$/).nil?
          return streetname.sub(/#{value}$/, '').single_space
        end
      end
    end
    return streetname;
  end
  
  
  # even needed? should just be model call
  def find_street(name)
    return Street.where("name LIKE ?", "%#{name}%")
  end

  def strip_address_number(streetname)
    streetname = streetname.upcase
    unless streetname.match(/^\d+\s/).nil?
      return streetname.sub(/^\d+\s/, '')      
    end    
    return streetname.single_space
  end

  def strip_address_unit(streetname)
    streetname = streetname.upcase.sub(/\,.+/, '')
    unless streetname.match(/^\d+\-\d+\s/).nil?
      # pair programming at it's best!
      # this is a weird mix of splits and regxp.
      return streetname.sub("-" + streetname.split(',')[0].split(' ')[0].split('-')[1], "")
    end    
    return streetname.single_space
  end


  def find_address(address_string)
    unless address_string
      return []
    end
    address_string = address_string.upcase.single_space

    if(address_string.start_with?("2332"))
      puts "1: #{address_string}"
    end

    address = Address.where("address_long = ?", "#{address_string}")
    unless address.empty?
      return address
    end

    # if there is no direct hit, then we look for units in the address
    # and strip the unit number
    address_string = strip_address_unit(address_string)
    if(address_string.start_with?("2332"))
      puts "2: #{address_string}"
    end
    address = Address.where("address_long = ?", "#{address_string}")
    unless address.empty?
        if(address_string.start_with?("2332"))
          puts "2.1 id: " +  address.first.id.to_s#{address_string}"
        end
      return address   
    end

    # first we match just by abbriviating street suffixes
    # if we match we return
    address_string = abbreviate_street_types(address_string)
    if(address_string.start_with?("2332"))
      puts "3: #{address_string}"
    end
    address = Address.where("address_long = ?", "#{address_string}")
    unless address.empty?
      return address   
    end

    address_string = abbreviate_street_direction(address_string)
    if(address_string.start_with?("2332"))
      puts "4: #{address_string}"
    end
    address = Address.where("address_long = ?", "#{address_string}")
    unless address.empty?
      return address   
    end
    return []
  end
end
