class Notifier < ActionMailer::Base
  default :from => "team@lostlookout.com"
  
  def listing_contact(recipient, message, listing, sender)
    mail(:to => recipient.email, :subject => "You have a response about #{listing.state_title}") do |format|
      @sender = sender
      @message = message
      @recipient = recipient
      @listing = listing
      
      format.html
    end
  end
  
  
end
