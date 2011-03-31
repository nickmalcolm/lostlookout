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
    (@content_for_title + " on " if @content_for_title).to_s + 'Lost Lookout - Lost and Found Near You.'
  end

  def page_meta_descr
    default = "Lost or Found something? Put it on the Lost Lookout map. "+
              "Let people know where to look out for your lost items, or"+
              "let owners quickly and easily reward you. Lost Lookout - "+
              "finding lost stuff near you!"
                  
    (@meta_descr.nil? ? default : @meta_descr ).to_s
  end
  
  def page_meta_tags
    default = "map, lost, found, "
                  
    default += (@meta_tags.nil? ? default : @meta_tags).to_s
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
    elsif p =~ /(\/users\/e(.*))|(\/listings\/\d\/e(.*))|(\/listings\/new)/
      scripts << :edit
      
    #Viewing listings
    elsif p.starts_with?"/listings/"
      scripts << :listings
    end
    
    return include_javascripts *scripts
  end
  
  def facebook_listing_like
    content_tag :iframe, nil, :src => "https://www.facebook.com/plugins/like.php?href=#{CGI::escape(request.url)}&layout=button_count&show_faces=false&width=100&height=80&action=recommend&font=arial&colorscheme=light", :style=>"width:130px;height:20px;float:right", :scrolling => 'no', :frameborder => '0', :allowtransparency => true, :id => :facebook_like
  end
  
  def facebook_home_like
    content_tag :iframe, nil, :src => "http://www.facebook.com/plugins/likebox.php?href=http%3A%2F%2Fwww.facebook.com%2Fpages%2FLost-Lookout%2F196459227043474&amp;width=292&amp;colorscheme=light&amp;show_faces=true&amp;stream=false&amp;header=true&amp;height=290", :scrolling=>"no", :frameborder=>"0", :style=>"max-height:290px; width: 100%;overflow:hidden;", :allowtransparency=>"true", :id=>"facebook_home_like"
  end
  
end
