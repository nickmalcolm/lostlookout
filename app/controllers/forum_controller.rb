class ForumController < ApplicationController
  
  def index
    @content_for_title = "Community"
  end
  
  def show
    @article = "Hello"
  end
  
end