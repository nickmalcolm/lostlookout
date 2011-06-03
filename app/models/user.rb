class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :trackable, :validatable
         
  has_many :listings
  has_many :topics
  has_many :posts
  
  validates_numericality_of :latitude, :allow_nil => true
  validates_numericality_of :longitude, :allow_nil => true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, 
                  :remember_me, :latitude, :longitude, :time_zone_str, :reverse_geocode, 
                  :display_name
                  
  before_save :set_display_name
  
  def set_display_name
    if self.display_name.blank?
      self.display_name = email.split("@")[0].capitalize
    end
    true
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
