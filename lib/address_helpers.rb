class String
  def single_space
    self.split.join(' ')
  end
end

module AddressHelpers

  @abbr = {'ST' => "STREET", 'AVE' => "AVENUE", 'DR'=> 'DRIVE', 'CT'=> "COURT", 'RD'=> 'ROAD', "LN" => 'LANE', 'PL' => 'PLACE', 'PARK' => 'PARK', 'BLVD' => 'BOULEVARD', 'ALY' => 'ALLEY'}

  def abbreviate_street_types(streetname)
    streetname = streetname.upcase
    @abbr.each do |(value, label)|
      unless streetname.match(/#{label}$/).nil?
        return streetname.sub(/#{label}$/, value)
      end
    end
    return streetname.single_space;
  end

  def unabbreviate_street_types(streetname)
    streetname = streetname.upcase
    @abbr.each do |(label, value)|
      unless streetname.match(/#{label}$/).nil?
        return streetname.sub(/#{label}$/, value)
      end
    end
    return streetname.single_space;
  end

  def get_street_type(streetname)
    streetname = streetname.upcase
    @abbr.each do |(label, value)|
      if !streetname.match(/#{label}$/).nil? || !streetname.match(/#{value}$/).nil?
        return label
      end
    end
    return streetname.single_space;
  end


  def get_street_name(streetname)
    streetname = streetname.to_s.upcase
    @abbr.each do |(label, value)|
      unless streetname.match(/#{label}$/).nil?
        return streetname.sub(/#{label}$/, '').single_space
      end
      
      unless streetname.match(/#{value}$/).nil?
        return streetname.sub(/#{value}$/, '').single_space
      end
    end
    return streetname.single_space;
  end
  
  def find_street(name)
    return Street.where("name LIKE ?", "%#{name}%")
  end


  def find_address(name)
    return Address.where("address_long LIKE ?", "%#{name}%")
  end

  

end