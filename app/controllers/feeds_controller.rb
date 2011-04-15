class FeedsController < ApplicationController
  
  layout false
  
  def index
    @listings = Listing.where(:is_open => true)
    @updated = @listings.first.created_at unless @listings.empty?
  end
end