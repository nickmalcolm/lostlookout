class ListingsController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:new, :edit, :poster, :create, :update, :destroy]
  
  # GET /listings
  def index
    @content_for_title = "Browse Lost and Found"
    @meta_descr = "Browse everything lost and found near you on map based Lost Lookout."
    
    order = Listing.sortable_to_column(0)
    if params[:sort]
      order = Listing.sortable_to_column(params[:sort])
    end
    
    @listings = Listing.search "", :sort_mode => :extended, :order => order, :conditions => {:is_open => 1}, :page => params[:page], :per_page => 20
    
    @meta_tags = ""
    @listings.each {|t| @meta_tags += t.meta_tags+", "}
    
    respond_to do |format|
      format.html # index.html.erb
      format.json do
        render :json => @listings.to_a, :status => 200
      end
    end
  end
  
  def search
    @content_for_title = "Searching for "+params[:search]
    @meta_descr = @content_for_title+" on map based lost and found, Lost Lookout."
    order = Listing.sortable_to_column(0)
    if params[:sort]
      order = Listing.sortable_to_column(params[:sort])
    end
    
    @listings = Listing.search params[:search], :sort_mode => :extended, :order => "@weight DESC, "+order, :page => params[:page], :per_page => 20
    @search_terms = params[:search]
    @count = @listings.count
    
    @meta_tags = params[:search].parameterize.split(/-/).join(", ")+", "
    @listings.each {|t| @meta_tags += t.meta_tags+", "}
  end

  # GET /listings/1
  def show
    @listing = Listing.find(params[:id])
    
    @content_for_title = @listing.state_title
    
    @photo = @listing.external_photos.first
    
    @meta_descr = @listing.state_title+" on Lost Lookout. Mapped based lost and found, finding lost stuff near you!"
    @meta_tags = @listing.meta_tags
    
    
    @map = initialize_map()
    @map.zoom = 16
    @map.center = [@listing.latitude, @listing.longitude]
    marker = @listing.to_cart
    marker.icon = (@listing.lost ? @lost : @found)
    marker.info_window_url = listing_bubble_path(@listing)
    @map.markers << marker
    
    respond_to do |format|
      format.html # show.html.erb
      format.json do
        render :json => @listing
      end
    end
  end
  
  def bubble
    @listing = Listing.preload(:external_photos).find(params[:listing_id])
    
    render :layout => false
  end
  
  def email_owner
    if current_user.sent_enough_emails?
      flash[:notice] = "You've sent enough emails today sorry! Wait until tomorrow ;)"
      redirect_to listing
    else  
      listing  = Listing.find(params[:id])
      recipient = listing.user
      message = params[:message]
      
      if !message.blank?
        Notifier.listing_contact(recipient, message, listing, current_user).deliver
        flash[:notice] = "Your email has been sent, thanks!"
      else
        flash[:notice] = "You need to write something in your message!"
      end
      
      redirect_to listing
    end
  end
  
  def close
    listing  = Listing.find(params[:id])
    if current_user.eql? listing.user
      if listing.is_open
        listing.close
        flash[:notice] = "That's great to hear! This listing is now closed!"
      else
        flash[:notice] = "This listing is already closed."
      end
    end
    
    redirect_to listing
  end
    
  def poster
    @content_for_title = "Poster"
    
    @listing = Listing.preload(:external_photos).find(params[:listing_id])
    @photo = @listing.external_photos.first
    
    @map = initialize_map()
    @map.zoom = 16
    @map.center = [@listing.latitude, @listing.longitude]
    marker = @listing.to_cart
    marker.icon = (@listing.lost ? @lost : @found)
    marker.info_window_url = listing_bubble_path(@listing)
    @map.markers << marker
    
    render :layout => false
  end
  

  # GET /listings/new
  def new
    @content_for_title = "New listing"
    @listing = Listing.new
    1.times { @listing.external_photos.build }

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /listings/1/edit
  def edit
    @listing = Listing.find(params[:id])
    if @listing.external_photos.size.eql? 0
      1.times { @listing.external_photos.build }
    end
    
    if !@listing.is_open
      flash[:error] = "This listing is closed"
      redirect_to @listing
    end
    
    @content_for_title = "Edit "+@listing.state_title
  end

  # POST /listings/new
  def create
    @listing = Listing.new(params[:listing])
    @listing.user = current_user

    respond_to do |format|
      if @listing.save
        format.html { redirect_to(@listing, :notice => 'Listing was successfully created.') }
      else
        flash[:error] = "Sorry, there are a few things you need to fix"
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /listings/1
  def update
    @listing = Listing.find(params[:id])
    
    @listing.user = current_user

    if @listing.is_open
      respond_to do |format|
        if @listing.update_attributes(params[:listing])
          format.html { redirect_to(@listing, :notice => 'Listing was successfully updated.') }
        else
          format.html { render :action => "edit" }
        end
      end
    end
  end
  
  before_filter :authenticate_api, :only => [:near]
  
  def near
    @listings = Listing.all
    
    respond_to do |format|
      format.json  { render :json => @listings }
    end
  end
  
  private
  
    def authenticate_api
      key = params[:token]
      key.eql?("f725435a26294dac2e90bbc588fcdeec")
    end
  
end
