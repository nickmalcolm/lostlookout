class ExternalPhotosController < ApplicationController
  # GET /external_photos
  # GET /external_photos.xml
  def index
    @external_photos = ExternalPhoto.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @external_photos }
    end
  end

  # GET /external_photos/1
  # GET /external_photos/1.xml
  def show
    @external_photo = ExternalPhoto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @external_photo }
    end
  end

  # GET /external_photos/new
  # GET /external_photos/new.xml
  def new
    @external_photo = ExternalPhoto.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @external_photo }
    end
  end

  # GET /external_photos/1/edit
  def edit
    @external_photo = ExternalPhoto.find(params[:id])
  end

  # POST /external_photos
  # POST /external_photos.xml
  def create
    @external_photo = ExternalPhoto.new(params[:external_photo])

    respond_to do |format|
      if @external_photo.save
        format.html { redirect_to(@external_photo, :notice => 'External photo was successfully created.') }
        format.xml  { render :xml => @external_photo, :status => :created, :location => @external_photo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @external_photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /external_photos/1
  # PUT /external_photos/1.xml
  def update
    @external_photo = ExternalPhoto.find(params[:id])

    respond_to do |format|
      if @external_photo.update_attributes(params[:external_photo])
        format.html { redirect_to(@external_photo, :notice => 'External photo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @external_photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /external_photos/1
  # DELETE /external_photos/1.xml
  def destroy
    @external_photo = ExternalPhoto.find(params[:id])
    @external_photo.destroy

    respond_to do |format|
      format.html { redirect_to(external_photos_url) }
      format.xml  { head :ok }
    end
  end
end
