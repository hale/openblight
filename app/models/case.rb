class Case < ActiveRecord::Base
  belongs_to :address
	
  has_many :hearings, :foreign_key => :case_number, :primary_key => :case_number
  has_many :inspections, :foreign_key => :case_number, :primary_key => :case_number
  has_many :demolitions, :foreign_key => :case_number, :primary_key => :case_number 
  has_one  :judgement, :foreign_key => :case_number, :primary_key => :case_number
  has_one  :case_manager, :foreign_key => :case_number, :primary_key => :case_number
  has_one  :foreclosure, :foreign_key => :case_number, :primary_key => :case_number
  has_many :resets, :foreign_key => :case_number, :primary_key => :case_number
  has_many :notifications, :foreign_key => :case_number, :primary_key => :case_number

  validates_presence_of :case_number
  validates_uniqueness_of :case_number

  self.per_page = 50

  def accela_steps
    steps_ary = []
    steps_ary << self.hearings << self.inspections << self.demolitions << self.resets << self.foreclosure << self.notifications
    steps_ary.flatten.compact.sort{ |a, b| a.date <=> b.date }
  end

  def assign_address(options = {})
    if options[:address_long]
      a = Address.where("address_long = ?", options[:address_long])
      if a.length == 1
        self.address = a.first
      elsif a.length > 1 && geopin
        #find by geopin and address
        a = Address.where( "address_long = :address_long AND geopin = :pin_num", {:address_long => options[:address_long], :pin_num => geopin} )
        if a.length = 1
          self.address = a.first
        end
      end
    elsif geopin
      a = Address.where(:geopin => geopin)
      if a.length === 1
        self.address = a.first
      end
    end
    self.save!
  end

  def most_recent_status
    self.accela_steps.last
  end

  def notices
    notices = []
    notices << self.notifications << Inspection.find_by_inspection_type("Posting of Hearing")
    notices.flatten.compact.sort{ |a, b| a.date <=> b.date }
  end

  def inspects
    inspects = Inspection.where("inspection_type <> 'Posting of Hearing' and case_number = '#{self.case_number}'")
  end
end
