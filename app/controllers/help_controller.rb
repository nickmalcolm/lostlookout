class HelpController < ApplicationController
  
  def index
    @content_for_title = "Help"
    @meta_descr = "Get answers to some common questions and learn how to make the most of Lost Lookout"
    @meta_tags = "help, question, answer, faq, support"
  end
  
  def privacy
    @content_for_title = "Privacy Policy"
    @meta_descr = "Read about Lost Lookout's commitment to your privacy"
    @meta_tags = "security, safety, rules, conditions, privacy, data"
  end
  
  def terms
    @content_for_title = "Terms and Condition"
    @meta_descr = "Get to know and accepts Lost Lookout's T&Cs before using the site."
    @meta_tags = "legal, security, safety, rules, conditions, privacy, data"
  end  
  
  def about
    @content_for_title = "About Lost Lookout"
    @meta_descr = "Find out what makes Lost Lookout tick. Information for press contact."
    @meta_tags = "about, behind the scenes, founder, nick malcolm, press"
  end
  
end