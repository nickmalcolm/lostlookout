class ListingCategory < ActiveRecord::Base
  
  has_many :listings
  
end
