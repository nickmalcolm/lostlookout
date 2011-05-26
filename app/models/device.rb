class Device < ActiveRecord::Base
  
  validates :apid, :presence => true, :uniqueness => true
  validates :area, :presence => true
  
  attr_accessible :apid, :area
  
  scope :located_in, lambda{ |area|
      Device.where(:area => area)
    } 
    
  def self.get_APIDs_as_JSON(area)
    devices = Device.located_in(area)
    apids = []
    devices.each do |d|
      apids << d.apid
    end
    
    apids
  end
  
end
