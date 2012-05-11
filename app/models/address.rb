class Address < ActiveRecord::Base
  belongs_to :street
  has_many :cases
  has_many :demolitions
  has_many :foreclosures
  has_many :maintenances

  has_many :inspections, :through => :cases
  has_many :notifications, :through => :cases
  has_many :hearings, :through => :cases
  has_many :judgements, :through => :cases

  validates_uniqueness_of :address_id
	#validates_uniqueness_of :parcel_id
  #validates_uniqueness_of :geopin

  self.per_page = 50

  def workflow_steps
    steps_ary = []
    self.cases.each do |c|
      steps_ary << c.accela_steps
    end
    steps_ary << self.demolitions 
    steps_ary.flatten.compact.sort{ |a, b| a.date <=> b.date }
  end

  def most_recent_status
    if !self.workflow_steps.empty?
      self.workflow_steps.last
    else
      nil
    end
  end

  def most_recent_status_preview
    s = self.most_recent_status
    {:type => s.class.to_s, :date => s.date.strftime('%e %B, %Y')}
  end

  def self.find_addresses_with_cases_by_street(street_string)
    Address.joins(:cases).where(:addresses => {:street_name => street_string})
  end

  def self.find_addresses_by_geopin(geopin)
 	 Address.where("geopin = ?", geopin)
  end

  def resolutions
    res_ary = []
    res_ary << self.foreclosures << self.demolitions << self.maintenances
    res_ary.flatten.compact
  end
end
