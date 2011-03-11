class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :trackable, :validatable
         
  has_many :listings
  
  validates_numericality_of :latitude, :allow_nil => true
  validates_numericality_of :longitude, :allow_nil => true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, 
                  :remember_me, :latitude, :longitude, :time_zone_str, :reverse_geocode
  
  def display_name
    if self.first_name.blank? || self.last_name.blank?
      self.email.split("@")[0]
    else
      self.first_name + " " + self.last_name
    end
  end
    
  def time_zone
    begin
      ActiveSupport::TimeZone.new(self.time_zone_str)
    rescue ArgumentError
      Time.zone
    end
  end
  
end
