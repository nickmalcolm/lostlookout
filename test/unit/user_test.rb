require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "create user" do
    u = User.new(:first_name => "Charles", :last_name => "Xavier", :email => "x@b.com", :password => "123abc", :confirmed_at => DateTime.now)
    assert u.save!
  end
  
  test "user factory works" do
    assert Factory(:user)
  end
  
  test "user display names" do
    u = Factory(:user, :email => "charles.xavier@xmen.com")
    
    assert_equal "Charles.xavier", u.display_name
    
    u.display_name = ""
    u.save!
    
    assert_equal "Charles.xavier", u.display_name
    
    u.display_name = "Nick"
    u.save!
    
    assert_equal "Nick", u.display_name
    
    #This is the old way. Make sure it doesn't work.
    u.first_name = "Nick"
    u.last_name = "Malcolm"
    u.save!
    
    assert_equal "Nick", u.display_name
    
    u.display_name = ""
    u.save!
    
    assert_equal "Charles.xavier", u.display_name
    
  end
  
end
