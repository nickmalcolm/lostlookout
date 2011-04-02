class TopicsController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update]
  before_filter :find_forum

  # GET /topics/1
  # GET /topics/1.xml
  def show
    @topic = Topic.find(params[:id])
    if current_user
      @topic.posts.new(:user => current_user)
    end
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /topics/new
  # GET /topics/new.xml
  def new
    @topic = @forum.topics.new
    @topic.posts.build(:user => current_user)

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
    p = @topic.posts.first
    p.user = current_user
    p.topic = @topic
    p.save!
    
    respond_to do |format|
      if @topic.save
        format.html { render :action => "show", :notice => "Topic successfully created" }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.xml
  def update
    @topic = Topic.find(params[:id])
    p = @topic.posts
    if(p.user.nil?)
      p.user = current_user
      p.topic = @topic
      p.save!
    end
    
    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to(:action => "show", :notice => 'Topic was successfully updated.') }
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
