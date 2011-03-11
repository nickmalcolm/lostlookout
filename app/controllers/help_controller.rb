class HelpController < ApplicationController
  
  def index
    @content_for_title = "Help"
  end
  
  def privacy
    @content_for_title = "Privacy Policy"
  end
  
  def terms
    @content_for_title = "Terms and Condition"
  end  
end