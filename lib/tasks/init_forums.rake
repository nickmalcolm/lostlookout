task :init_forums => :environment do

    Forum.find_or_create_by_title("Lost Lookout discussion", 
    :description=>"Share stories, talk about cool lost and found stuff, anything to do with Lost Lookout.")
    
    Forum.find_or_create_by_title("Tips, hints and help", 
    :description=>"Discuss how you make your Lost Lookout experience better, or ask for help")
    
    Forum.find_or_create_by_title("General", 
    :description=>"Talk about anything you like!")

end