atom_feed do |feed|
  
  feed.title "Lost and Found on LostLookout.com"
  feed.subtitle "Map based lost and found"

  feed.updated @updated
  
  feed.logo root_url+"images/lost_lookout_on_white_logo.png"
  feed.icon root_url+"apple-touch-icon.png"
  feed.rights "(C) 2011 Nick Malcolm"
  feed.author do |a|
    a.name  "Lost Lookout"
    a.email "team@lostlookout.com"
    a.uri "http://lostlookout.com/about"
  end

  unless @listings.nil?
    @listings.each do |listing|
      feed.entry listing do |entry|
        
        entry.title h(listing.state_title)
        
        summary = truncate(strip_tags(listing.description),  :length => 60)
        rg = listing.reverse_geocode.split(',')
        summary += " "+listing.lost_to_s+" near "
        summary += rg[0]+","+rg[1]
        entry.summary summary
        
        entry.content listing.description+" "+listing.state_reverse_geocode

        entry.author do |author|
          author.name listing.user.display_name
          author.uri root_url[0..root_url.length-2]+(profile_path listing.user)
        end
      end
    end
  end
end