class HomeController < ApplicationController
  
  def index
    @content_for_title = "Home map"
    @listings = Listing.where(:is_open => true).preload(:external_photos).order("listings.created_at DESC")
    
    @sidebar = @listings[0..2]
    
    
    @map = initialize_map()
    
    @listings.each do |l|
      marker = l.to_cart
      marker.icon = (l.lost ? @lost : @found)
      marker.info_window_url = listing_bubble_path(l)
      @map.markers << marker
      
    end
    
    @meta_tags = ""
    @listings.each {|t| @meta_tags += t.title.split(/ /).join(", "); @meta_tags += ", "}
    
  end
  
  
  
end