task :daily_update => :environment do
  
  signed_up_today = User.find(:all, :conditions=>["created_at > ?", 1.day.ago])
  
  m = "<p>#{signed_up_today.count} users signed up today! They are:</p><ul>"
  
  signed_up_today.each do |u|
    m += "<li>#{u.email} (confirmed: #{u.confirmed?})</li>"
  end
  
  m += "</ul>"
  
  Notifier.mail_admin(m).deliver
  
  puts "Daily update sent!"
  
end