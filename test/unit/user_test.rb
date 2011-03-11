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
    u = Factory(:user, :first_name => "Charles", :last_name => "Xavier", :email => "charles.xavier@xmen.com")
    
    assert_equal "Charles Xavier", u.display_name
    
    u.first_name = nil
    u.last_name = nil
    u.save
    u.reload
    
    assert_equal "charles.xavier", u.display_name
    
    u.first_name = ""
    u.last_name = ""
    u.save
    u.reload
    
    assert_equal "charles.xavier", u.display_name
    
  end
  
end
