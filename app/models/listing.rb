class Listing < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :listing_category
  
  has_many :external_photos, :dependent => :destroy
  accepts_nested_attributes_for :external_photos, :reject_if => lambda { |e| e[:raw_url].blank? }, :allow_destroy => true
  
  validates_presence_of :title
  validates_length_of   :title, :within=>2..30
  
  validates_presence_of :user
  
  validates_presence_of :latitude
  validates_presence_of :longitude
  validates_presence_of :reverse_geocode
  
  validates_presence_of :last_seen_at
  validates :last_seen_at, :date => {:before_or_equal_to => Time.zone.now, :message => "date is in the future!"}
  
  validates_numericality_of :value, :allow_nil => true, :greater_than_or_equal_to => 0
  validates_numericality_of :reward, :allow_nil => true, :greater_than_or_equal_to => 0
  
  before_validation :initialize_external_photos, :on => :create

  def initialize_external_photos
    external_photos.each { |e| e.listing = self }
  end
  
  
  def self.states
    [ 'open', 'closed' ]
  end

  validates_inclusion_of :state, :in => self.states
  
  
  define_index do
    indexes :title,           :sortable => true
    indexes :description
    indexes :value,           :type => :integer, :sortable => true
    indexes :reward,          :type => :integer, :sortable => true
    indexes :reverse_geocode
    indexes :lost,            :sortable => true
    indexes :last_seen_at,    :sortable => true
  end
  
  def state_title
    s = self.lost_to_s
    s += " "+self.title.truncate(23, :separator => ' ')
  end
  
  def lost_to_s
    s = self.lost ? "Lost" : "Found"
  end
  
  
  def self.respond_with_json(params)
    p params
    Listing.all
  end
  
  def short_desc
    #80 chars, no line returns, ... ending
    d = description.html_safe.gsub(/\r\n?/, " ")[0..120]+"..."
  end
  
  def as_json(options={})
    hash = Hash.new
    hash[:longitude] = longitude.to_f
    hash[:latitude] = latitude.to_f
    hash[:html] =  self.html_description
    hash[:popup] = false
    hash[:url] = "/listings/"+id.to_s
  
    return hash
  end
  
  def to_cart
    Cartographer::Gmarker.new(:name=> "listing"+self.id.to_s,
              :position => [self.latitude.to_f,self.longitude.to_f])
  end
  
  def time_ago
    seconds = (Time.now - self.last_seen_at)
    
    if seconds > 60
      minutes = seconds/60
    else
      return "#{seconds.to_i} second"+(seconds.to_i == 1 ? "" : "s")+" ago"
    end
    
    if minutes > 60
      hours = minutes/60
    else
      return "#{minutes.to_i} minute"+(minutes.to_i == 1 ? "" : "s")+" ago"
    end
    
    if hours > 24
      days = hours/24
    else
      return "#{hours.to_i} hour"+(hours.to_i == 1 ? "" : "s")+" ago"
    end
    
    return "#{days.to_i} day"+(days.to_i == 1 ? "" : "s")+" ago"
  end
  
  def self.sortable
    [
      ["Title",               0],
      ["Lost first",          1], 
      ["Found first",         2], 
      ["Highest Value",       3], 
      ["Highest Reward",      4], 
      ["Most recently seen",  5]
    ]
  end
  
  def self.sortable_to_column(opt)
    title = " title ASC"
    case opt
    when "0"
      return title
    when "1"
      return "lost DESC"+title
    when "2"
      return "lost ASC"+title
    when "3"
      return "value DESC"+title
    when "4"
      return "reward DESC"+title
    when "5"
      return "last_seen_at DESC"+title
    end
  end
end
