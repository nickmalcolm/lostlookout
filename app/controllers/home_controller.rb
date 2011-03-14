class HomeController < ApplicationController
  
  def index
    @listings = Listing.preload(:external_photos).order("listings.created_at DESC")
    
    @sidebar = @listings[0..2]
    
    
    @map = initialize_map()
    
    @listings.each do |l|
      marker = l.to_cart
      marker.icon = (l.lost ? @lost : @found)
      marker.info_window_url = listing_bubble_path(l)
      @map.markers << marker
    end
    
  end
  
  
  
end