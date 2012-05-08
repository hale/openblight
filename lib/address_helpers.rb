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
      unless streetname.match(/\s#{label}$/).nil?
        return streetname.sub(/\s#{label}$/, value)
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
    @street_direction.each do |(label, value)|
      unless streetname.match(/\s#{label}\s/).nil?
        return streetname.sub(/\s#{label}\s/, ' ' + value + ' ')
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
        unless streetname.match(/\s#{label}$/).nil?
          return streetname.sub(/\s#{label}$/, '').single_space
        end
      
        unless streetname.match(/#{value}$/).nil?
          return streetname.sub(/#{value}$/, '').single_space
        end
      end
    end
    return streetname;
  end

  def remove_direction(streetname)
      @street_direction.each do |(label, value)|
        unless streetname.match(/#{label}/).nil?
          return streetname.sub(/#{label}/, value)
        end
      end
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

  def strip_direction(streetname)
    streetname = streetname.upcase
    @street_direction.each do |(label, value)|
      unless streetname.match(/^\d+\s#{label}\s/).nil?
        return streetname.sub(/\s#{label}\s/, ' ')     
      end    
    end
    return streetname.single_space
  end
  def find_address(address_string)
    unless address_string
      return []
    end
    address_string = address_string.upcase.single_space
    address_string = address_string.delete('.')
    
    address = Address.where("address_long = ?", "#{address_string}")
    unless address.empty?
      return address
    end

    # if there is no direct hit, then we look for units in the address
    # and strip the unit number
    address_string = strip_address_unit(address_string)
    address = Address.where("address_long = ?", "#{address_string}")
    unless address.empty?
      return address   
    end

    # first we match just by abbriviating street suffixes
    # if we match we return
    address_string = unabbreviate_street_types(address_string)
    address = Address.where("address_long = ?", "#{address_string}")
    unless address.empty?
      return address   
    end

    # first we match just by abbriviating street suffixes
    # if we match we return
    address_string = abbreviate_street_types(address_string)
    address = Address.where("address_long = ?", "#{address_string}")
    unless address.empty?
      return address   
    end

    address_string = abbreviate_street_direction(address_string)
    address = Address.where("address_long = ?", "#{address_string}")
    unless address.empty?
      return address   
    end

    
    address_street = strip_direction(address_string)
    address_street = get_street_name(address_street)
    address = Address.where("house_num = ? and street_name = ?", "#{address_string.split(' ')[0]}", "#{address_street}")
    unless address.empty?
      return address   
    end
    puts "Not matched: #{address_string}"
    return []
  end
end
