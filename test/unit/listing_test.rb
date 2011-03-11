require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  # Replace this with your real tests.
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
    
end
