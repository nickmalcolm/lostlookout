include TweetButton

module ApplicationHelper

  def is_home
    self.controller.class == HomeController
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, ("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
  end
  
  def page_title
    (@content_for_title + " on " if @content_for_title).to_s + 'Lost Lookout - Finding Lost Stuff Near You.'
  end

  def page_heading(text)
    content_tag(:h1, content_for(:title){ text })
  end
  
  def javascript_includes
    p = request.path
    p request.path == listings_path
    scripts = [:bottom]
    
    #Homepage
    if p == root_path
      scripts << :home
      
    #if editing users or listings
    elsif p =~ /(\/users\/e(.*))|(\/listings\/\d\/e(.*))/
      scripts << :edit
      
    #Viewing listings
    elsif p.starts_with?"/listings/"
      scripts << :listings
    end
    
    return include_javascripts *scripts
  end
  
  def facebook_like
    content_tag :iframe, nil, :src => "https://www.facebook.com/plugins/like.php?href=#{CGI::escape(request.url)}&layout=button_count&show_faces=false&width=100&height=80&action=recommend&font=arial&colorscheme=light", :style=>"width:130px;height:20px;float:right", :scrolling => 'no', :frameborder => '0', :allowtransparency => true, :id => :facebook_like
  end
  
end
