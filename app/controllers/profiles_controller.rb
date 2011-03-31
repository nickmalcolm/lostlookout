class ProfilesController < ApplicationController

before_filter :authenticate_user!, :except => :show
 
  def dashboard
    @username = current_user.display_name
    @joindate = current_user.created_at
    @content_for_title = "Your Lookout"
    @meta_descr = @content_for_title+" on map based Lost Lookout."
    @meta_tags = "lookout, dashboard, listings, settings"
    
    order = "title ASC"
    if params[:sort]
      order = current_user.listings.sortable_to_column(params[:sort])
    end
    @listings = Listing.search "", :conditions => {:user_id => current_user.id}, :sort_mode => :extended, :order => order
      
  end

  def show
    user = User.find(params[:id])
    @username = user.display_name
    @joindate = user.created_at
    
    @content_for_title = @username+"'s Profile"
    @meta_descr = @content_for_title+" on map based Lost Lookout."
    @meta_tags = @username+", profile, listings, settings"
    
    order = "title ASC"
    if params[:sort]
      order = user.listings.sortable_to_column(params[:sort])
    end
    @listings = Listing.search "", :conditions => {:user_id => user.id}, :sort_mode => :extended, :order => order, :populate => true
    
  end
 
end