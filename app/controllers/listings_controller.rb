class ListingsController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:new, :edit, :poster, :create, :update, :destroy]

  
  # GET /listings
  def index
    @content_for_title = "Browse Lost and Found"
    
    order = "title ASC"
    if params[:sort]
      order = Listing.sortable_to_column(params[:sort])
    end
    
    @listings = Listing.search "", :sort_mode => :extended, :order => order, :page => params[:page], :per_page => 20
    
    respond_to do |format|
      format.html # index.html.erb
      format.json do
        render :json => @listings
      end
    end
    
    @meta_descr = "Browse all the lost and found stuff near you on Lost Lookout"
  end
  
  def search
    @content_for_title = "Searching for "+params[:search]
    
    order = "title ASC"
    if params[:sort]
      order = Listing.sortable_to_column(params[:sort])
    end
    
    @listings = Listing.search params[:search], :sort_mode => :extended, :order => order, :page => params[:page], :per_page => 20
    @search_terms = params[:search]
    @count = @listings.count
    
    @meta_descr = "Search all the lost and found stuff near you on Lost Lookout"
  end

  # GET /listings/1
  def show
    
    @listing = Listing.find(params[:id])
    
    @content_for_title = @listing.state_title
    
    @photo = @listing.external_photos.first
    
    @meta_descr = "Check out "+@listing.state_title+", put on Lost Lookout. Mapped based lost and found, finding lost stuff near you!"
    
    
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
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /listings/1
  def update
    @listing = Listing.find(params[:id])
    
    @listing.user = current_user

    respond_to do |format|
      if @listing.update_attributes(params[:listing])
        format.html { redirect_to(@listing, :notice => 'Listing was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.xml
  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy

    respond_to do |format|
      format.html { redirect_to(listings_url) }
    end
  end
end
