require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  
  test "a lost listing" do
    u = Factory(:user)
    begin
      l = Listing.create(:title =>"Hello", :reverse_geocode => "a", :longitude => 1,
                      :latitude => 1, :last_seen_at => 5.seconds.ago, :lost => true)
      l.user = u
      l.save!
    rescue StandardError => error
      fail "Should be able to create lost listing: #{error}"
    end
  end
  
  test "a found listing" do
    u = Factory(:user)
    begin
      l = Listing.create(:title =>"Hello", :reverse_geocode => "a", :longitude => 1,
                      :latitude => 1, :last_seen_at => 5.seconds.ago, :lost => false)
      l.user = u
      l.save!
    rescue StandardError => error
      fail "Should be able to create found listing: #{error}"
    end
  end
  
  
  test "date in the past" do
    assert Factory(:listing, :last_seen_at => 2.hours.ago)
  end
  
  test "create no date in the future" do
    begin
      Factory(:listing, :last_seen_at => 2.hours.from_now)
    rescue
      #Good!
    else
      fail "Should not create a listing which was seen in the future"
    end
  end
  
  test "update no date in the future" do
    l = Factory(:listing, :last_seen_at => 1.minute.ago)
  
    begin
      l.last_seen_at = 2.hours.from_now
      l.save!
    rescue
      #Good!
    else
      fail "Should not update a listing to be seen in the future"
    end
  end
  
  test "valid value" do
    assert Factory(:listing, :value => 10.50)
    assert Factory(:listing, :value => 0.00)
    assert Factory(:listing, :value => nil)
    
    begin
      l = Factory(:listing, :value => -0.50)
    rescue
      #Good!
    else  
      fail "Should not create a listing with negative value of #{l.value}"
    end
    
    l = Factory(:listing, :value => 1)
  
    begin
      l.value = -1
      l.save!
    rescue
      #Good!
    else
      fail "Should not update a listing to have a negative value"
    end
  end
  
  test "tweet text" do
    l = Factory(:listing, :title=>"I am a 40 character title. That is long!")
    
    assert l.twitter_text.length
  end
  
  test "a listing can have a length of <= 500 characters" do
    u = Factory(:user)
    
    m = ""
    
    500.times {m+="a"}
      
    l = Listing.new(:title =>"Hello", :reverse_geocode => "a", :longitude => 1,
                    :latitude => 1, :last_seen_at => 5.seconds.ago, :lost => true,
                    :description => m)
    
    l.user = u                
    assert l.save!
    
    l.reload
    assert_equal 500, l.description.length
    
  end
  
  test "listing description must be <= 500 characters" do 
    u = Factory(:user)

    m = ""

    501.times {m+="a"}

    l = Listing.new(:user => u, :title =>"Hello", :reverse_geocode => "a", :longitude => 1,
                    :latitude => 1, :last_seen_at => 5.seconds.ago, :lost => true,
                    :description => m)
    
    begin
      l.save!
      fail "Shouldn't be able to save with descr > 500"
    rescue ActiveRecord::RecordInvalid
      #Yay!
    end
  end
    
end
