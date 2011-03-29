class ExternalPhoto < ActiveRecord::Base
  
  belongs_to :listing
  
  validates_presence_of :listing
  validates_presence_of :raw_url
  
  validates_format_of :raw_url, :with => /\A(http:\/\/)((i|www)\.)?imgur.com\/([a-zA-Z0-9]+)(.(png|jpg|gif))?\Z/
  
  before_save :clean_and_create_urls
  
  attr_accessible :raw_url
  
  def clean_and_create_urls
    wrong_url = "http://imgur.com/"
    url = self.raw_url
    if url.starts_with?(wrong_url)
      self.raw_url = "http://i.imgur.com/"+url.split(wrong_url)[1]
    end
    
    create_view_urls
  end
  
  def create_view_urls
    imgur = "http://i.imgur.com/"
    id = raw_url.split(/.com\//)[1].split(".")[0]
    ext = raw_url.split(/.com\//)[1].split(".")[1]
    ext = ext.nil? ? "jpg" : ext
    
    self.large_url = imgur+id+"l."+ext
    self.medium_url = imgur+id+"m."+ext
    self.small_url = imgur+id+"s."+ext
  end
  
end
