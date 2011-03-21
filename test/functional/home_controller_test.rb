require 'test_helper'
class HomeControllerTest < ActionController::TestCase
  
  include Devise::TestHelpers
  
  test "Can log in and see homepage" do
  
    a = Factory(:user)
    
    sign_in :user, a
  
    get :index
    assert_response :success
  end

  test "Can see own listings" do
  
    a = Factory(:user)
    
    sign_in :user, a
    
    Factory(:listing, :title => "My bracelet", :user => a)
  
    get :index
    assert_response :success
    assert_select "table.listings tr", :count => 1
    
    
    Factory(:listing, :title => "Two front teeth", :user => a, :lost => false)
    
    get :index
    assert_response :success
    assert_select "table.listings tr", :count => 2
  end
  
  
  test "Can see everyone's listings" do
  
    a = Factory(:user)
    Factory(:listing, :title => "My bracelet", :user => a)
    
    sign_in :user, a
    
    get :index
    assert_response :success
    assert_select "table.listings tr", :count => 1
    
    b = Factory(:user)
    Factory(:listing, :title => "Two front teeth", :user => b, :lost => false)
    
    get :index
    assert_response :success
    assert_select "table.listings tr", :count => 2
  end
  
  test "Anon can see everyone's listings" do
  
    a = Factory(:user)    
    b = Factory(:user)
    Factory(:listing, :title => "My bracelet", :user => a)
    Factory(:listing, :title => "Two front teeth", :user => b, :lost => false)
    
    get :index
    assert_response :success
    assert_select "table.listings tr", :count => 2
  end
  
  test "Closed listings are not shown on homepage" do
    b = Factory(:user)
    l = Factory(:listing, :title => "My bracelet", :user => b)
    Factory(:listing, :title => "Two front teeth", :user => b, :lost => false)
    
    get :index
    assert_response :success
    assert_select "table.listings tr", :count => 2
    
    l.close
    
    get :index
    assert_response :success
    assert_select "table.listings tr", :count => 1
  end  
  
end