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
                  :remember_me, :latitude, :longitude, :time_zone_str, :reverse_geocode,
                  :display_name, :emails_sent
                  
  before_save :set_display_name
  
  def set_display_name
    if first_name.blank? || last_name.blank?
      self.display_name = email.split("@")[0].capitalize
    else
      self.display_name = first_name.capitalize + " " + last_name.capitalize
    end
  end
    
  def time_zone
    begin
      ActiveSupport::TimeZone.new(self.time_zone_str)
    rescue ArgumentError
      Time.zone
    end
  end
  
  def sent_enough_emails?
    return emails_sent >= 6
  end
  
end
