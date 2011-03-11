task :generate_random_listings => :environment do
  desc "Generates random listings. Accepts overrides N as the number of listings to generate and USER_ID as the User.id (defaults to 10 and 5)"
  
  
  user = ENV["USER_ID"].nil? ? User.find(5) : User.find(ENV["USER_ID"].to_i)

  limit = ENV["N"].nil? ? 10 : ENV["N"].to_i
  
  puts "Generating #{limit} random listings by user #{user.id}"

  for i in 1..limit do
    rand_lat = -34 - rand(12) + rand
    rand_long = 166.5 + rand(11) + rand
    user.listings.create!( :title => "Random Listing #{i}", :latitude => rand_lat, :longitude => rand_long)
  end
end