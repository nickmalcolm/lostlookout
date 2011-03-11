class ProfilesController < ApplicationController

before_filter :authenticate_user!, :except => :show
 
  def dashboard
    @username = current_user.display_name
    @joindate = current_user.created_at
    @content_for_title = @username+"'s Dashboard"
    
    order = "title ASC"
    if params[:sort]
      order = current_user.listings.sortable_to_column(params[:sort])
    end
    @listings = Listing.where(:user_id=>current_user.id).search "", :sort_mode => :extended, :order => order
      
  end

  def show
    user = User.find(params[:id])
    @username = user.display_name
    @joindate = user.created_at
    
    order = "title ASC"
    if params[:sort]
      order = user.listings.sortable_to_column(params[:sort])
    end
    @listings = Listing.where(:user_id=>user.id).search "", :sort_mode => :extended, :order => order, :populate => true
    
    @content_for_title = @username+"'s Profile"
  end
 
end