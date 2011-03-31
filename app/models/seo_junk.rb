class SEOJunk
  
  
  def self.listing_seo_tags(listings, limit = 5)
    tags = ""
    listings.find( :all, :select => 'title', :limit => limit ).each do |t| 
      tags += t.title.split(/ /).join(", ") 
      tags += ", "
    end
    tags
  end
  
end