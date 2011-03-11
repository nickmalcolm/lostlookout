class ListingCategoriesController < ApplicationController
  # GET /categories
  # GET /categories.xml
  def index
    @categories = ListingCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = ListingCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @category = ListingCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = ListingCategory.find(params[:id])
  end

  # POST /categories
  # POST /categories.xml
  def create
    @category = ListingCategory.new(params[:listing_category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to(@category, :notice => 'ListingCategory was successfully created.') }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = ListingCategory.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:listing_category])
        format.html { redirect_to(@category, :notice => 'ListingCategory was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = ListingCategory.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(listing_categories_url) }
      format.xml  { head :ok }
    end
  end
end
