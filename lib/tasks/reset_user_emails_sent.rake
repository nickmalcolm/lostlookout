task :reset_user_emails_sent => :environment do

    User.update_all 'emails_sent = 0', 'emails_sent > 0'
    puts "#### All users emails_sent is now 0"

end