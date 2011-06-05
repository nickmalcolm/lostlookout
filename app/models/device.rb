class Device < ActiveRecord::Base
  
  validates :apid, :presence => true, :uniqueness => true
  validates :area, :presence => true
  
  after_save :update_listings
  
  attr_accessible :apid, :area, :latitude, :longitude
  
  scope :located_in, lambda{ |area|
      Device.where(:area => area)
    } 
    
  scope :near, lambda{ |*args|
                        origin = *args.first[:origin]
                        if (origin).is_a?(Array)
                          origin_latitude, origin_longitude = origin
                        else
                          origin_latitude, origin_longitude = origin.latitude, origin.longitude
                        end
                        origin_latitude, origin_longitude = self.deg2rad(origin_latitude), self.deg2rad(origin_longitude)
                        within = *args.first[:within]
                        {
                          :conditions => %(
                            (ACOS(COS(#{origin_latitude})*COS(#{origin_longitude})*COS(RADIANS(devices.latitude))*COS(RADIANS(devices.longitude))+
                            COS(#{origin_latitude})*SIN(#{origin_longitude})*COS(RADIANS(devices.latitude))*SIN(RADIANS(devices.longitude))+
                            SIN(#{origin_latitude})*SIN(RADIANS(devices.latitude)))*3963) <= #{within}),
                          :select => %(devices.*,
                            (ACOS(COS(#{origin_latitude})*COS(#{origin_longitude})*COS(RADIANS(devices.latitude))*COS(RADIANS(devices.longitude))+
                            COS(#{origin_latitude})*SIN(#{origin_longitude})*COS(RADIANS(devices.latitude))*SIN(RADIANS(devices.longitude))+
                            SIN(#{origin_latitude})*SIN(RADIANS(devices.latitude)))*3963) AS distance
                          )
                        }
                      }
    def self.deg2rad(degree)
      degree*Math::PI/180
    end
    
  def self.get_APIDs_as_JSON(area)
    devices = Device.located_in(area)
    apids = []
    devices.each do |d|
      apids << d.apid
    end
    
    apids
  end
  
  def self.get_APIDs_from_latlng(lat, lng, within = 10)
    apids = []
    unless lat.nil? || lng.nil?
      devices = Device.near(:origin => [lat,lng], :within => within)
      devices.each do |d|
        apids << d.apid
      end
    
      apids
    end 
  end
  
  def update_listings
    #Update all the listings near this mobile (20km)
    unless latitude.nil? || longitude.nil?
      near = Listing.where(:is_open => true).near(:origin => [latitude, longitude], :within => 10)
      near.update_all "mobile_lookout_count = mobile_lookout_count + 1"
    end
    true
  end
  
end
