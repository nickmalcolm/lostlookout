class TopicsController < ApplicationController
  
  before_filter :find_forum
  
  # GET /topics
  # GET /topics.xml
  def index
    @topics = Topic.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /topics/1
  # GET /topics/1.xml
  def show
    @topic = Topic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /topics/new
  # GET /topics/new.xml
  def new
    @topic = @forum.topics.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.xml
  def create
    @topic = @forum.topics.new(params[:topic])
    @topic.user = current_user

    respond_to do |format|
      if @topic.save
        format.html { redirect_to(@topic, :notice => 'Topic was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.xml
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to(@topic, :notice => 'Topic was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  
  # your actions go here

  private

    def find_forum
      @forum = Forum.find(params[:forum_id]) if params[:forum_id]
    end
end
