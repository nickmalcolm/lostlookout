class Listing < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :listing_category
  
  has_many :external_photos, :dependent => :destroy
  accepts_nested_attributes_for :external_photos, :reject_if => lambda { |e| e[:raw_url].blank? }, :allow_destroy => true
  
  validates_presence_of :title
  validates_length_of   :title, :within=>2..40
  
  validates_length_of :description, :within=>0..500, :allow_nil => true
  
  validates_presence_of :user
  
  validates_inclusion_of :lost, :in => [true, false]
  
  validates_presence_of :latitude
  validates_presence_of :longitude
  validates_presence_of :reverse_geocode
  
  validates_presence_of :last_seen_at
  validates :last_seen_at, :date => {:before_or_equal_to => Time.zone.now, :message => "date is in the future!"}
  
  validates_numericality_of :value, :allow_nil => true, :greater_than_or_equal_to => 0
  validates_numericality_of :reward, :allow_nil => true, :greater_than_or_equal_to => 0
  
  before_validation :initialize_external_photos, :on => :create
  
  attr_accessible :lost, :title, :description, :longitude, :latitude, 
                  :last_seen_at, :reverse_geocode, :value, :reward,
                  :external_photos_attributes, :area
  
  after_create :email_admin

  def to_param
      "#{id}-#{state_title.parameterize}"
  end
  
  def meta_tags
    "#{state_title.parameterize}".split(/-/).join(", ")
  end

  def initialize_external_photos
    external_photos.each { |e| e.listing = self }
  end
  
  
  define_index do
    indexes :title,           :sortable => true
    indexes :description
    indexes :value,           :type => :integer, :sortable => true
    indexes :reward,          :type => :integer, :sortable => true
    indexes :reverse_geocode
    indexes :is_open
    indexes :created_at,      :sortable => true
    indexes :user_id,         :type => :integer
    indexes :lost,            :sortable => true
    indexes :last_seen_at,    :sortable => true
  end
  
  def close
    self.is_open = false
    self.save!
  end
  
  #Defaults to no truncation
  def state_title(length = title.length)
    s = self.lost_to_s
    s += " "+self.title.truncate(length, :separator => ' ')
    
    if !self.is_open
      s = "Reunited! - "+s
      if !length.eql? title.length
        s.truncate(length+12, :separator => ' ')
      end
    end
    
    s
  end
  
  def state_reverse_geocode
    s = ""
    if self.lost
      s += "Look out around "
    else
      s += "Found near " 
    end
    
    s += reverse_geocode
  end
  
  def lost_to_s
    s = self.lost ? "Lost" : "Found"
  end
  
  def short_desc
    #120 chars, no line returns, ... ending
    d = description.html_safe.gsub(/\r\n?/, " ")[0..120]+"..."
  end
  
  def as_json(options={})
    hash = Hash.new
    hash[:lost] = lost
    hash[:longitude] = longitude.to_f
    hash[:latitude] = latitude.to_f
    hash[:title]= title
    hash[:description] = description
    hash[:url] = "/listings/"+id.to_s
    hash[:id] = id
    return hash
  end
  
  def to_cart
    Cartographer::Gmarker.new(:name=> "listing"+self.id.to_s,
              :position => [self.latitude.to_f,self.longitude.to_f])
  end
  
  def twitter_text
    locality_arr = reverse_geocode.split(',')
    locality = locality_arr[0]+ (locality_arr[1] ? ","+locality_arr[1] : "")
    text = state_title+" around #{locality}."+" Please RT and help me find "
    text += lost ? "it" : "the owner"
    text += "!"
  end
  
  def self.sortable
    [
      ["Most recently added", 0],
      ["Title",               1],
      ["Lost first",          2], 
      ["Found first",         3], 
      ["Highest Value",       4], 
      ["Highest Reward",      5], 
      ["Most recently seen",  6]
    ]
  end
  
  def self.sortable_to_column(opt)
    title = ", title ASC"
    case opt.to_i
    when 0
      return "created_at DESC"+title
    when 1
      return title
    when 2
      return "lost DESC"+title
    when 3
      return "lost ASC"+title
    when 4
      return "value DESC"+title
    when 5
      return "reward DESC"+title
    when 6
      return "last_seen_at DESC"+title
    end
  end
  
  def email_admin
    m  = "<p>There's a new listing!</p>"
    m += "#{user.display_name} made the listing <a href=\"http://lostlookout.com/listings/#{id}\">#{state_title}</a>"

    Notifier.mail_admin(m).deliver
  end
  
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
                            (ACOS(COS(#{origin_latitude})*COS(#{origin_longitude})*COS(RADIANS(listings.latitude))*COS(RADIANS(listings.longitude))+
                            COS(#{origin_latitude})*SIN(#{origin_longitude})*COS(RADIANS(listings.latitude))*SIN(RADIANS(listings.longitude))+
                            SIN(#{origin_latitude})*SIN(RADIANS(listings.latitude)))*3963) <= #{within}),
                          :select => %(listings.*,
                            (ACOS(COS(#{origin_latitude})*COS(#{origin_longitude})*COS(RADIANS(listings.latitude))*COS(RADIANS(listings.longitude))+
                            COS(#{origin_latitude})*SIN(#{origin_longitude})*COS(RADIANS(listings.latitude))*SIN(RADIANS(listings.longitude))+
                            SIN(#{origin_latitude})*SIN(RADIANS(listings.latitude)))*3963) AS distance
                          )
                        }
                      }
  def self.deg2rad(degree)
    degree*Math::PI/180
  end
  
end
