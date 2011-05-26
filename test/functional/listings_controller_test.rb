require 'test_helper'

class ListingsControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  #INDEX

  test "Can see own listings" do

    ThinkingSphinx::Test.start
    a = Factory(:user)

    sign_in :user, a

    l = Factory(:listing, :title => "My bracelet", :user => a)
    l.save!

    assert l.is_open
    assert_equal 1, Listing.all.count

    ThinkingSphinx::Test.index

    get :index
    assert_response :success

    #p (get :index).body

    assert_select ".listing", :count => 1


    Factory(:listing, :title => "Two front teeth", :user => a, :lost => false)

    get :index
    assert_response :success
    assert_select ".listing", :count => 2

    ThinkingSphinx::Test.stop
  end


  test "Can see everyone's listings" do

    a = Factory(:user)
    Factory(:listing, :title => "My bracelet", :user => a)

    sign_in :user, a

    get :index
    assert_response :success
    assert_select ".listing", :count => 1

    b = Factory(:user)
    Factory(:listing, :title => "Two front teeth", :user => b, :lost => false)

    get :index
    assert_response :success
    assert_select ".listing", :count => 2
  end

  test "Anon can see everyone's listings" do
    ThinkingSphinx::Test.start
    a = Factory(:user)    
    b = Factory(:user)
    Factory(:listing, :title => "My bracelet", :user => a)
    Factory(:listing, :title => "Two front teeth", :user => b, :lost => false)
    ThinkingSphinx::Test.index
    get :index
    assert_response :success
    assert_select ".listing", :count => 2
    ThinkingSphinx::Test.stop
  end

  test "Closed listings are not shown on homepage" do
    b = Factory(:user)
    l = Factory(:listing, :title => "My bracelet", :user => b)
    Factory(:listing, :title => "Two front teeth", :user => b, :lost => false)

    get :index
    assert_response :success
    assert_select ".listing", :count => 2

    l.close

    get :index
    assert_response :success
    assert_select ".listing", :count => 1
  end

  #SHOW

  test "should show value" do
    listing = Factory(:listing, :value => 5.75)
    get :show, :id => listing.to_param

    #Plus 1 for the tr header row
    assert_select "value", "<b>Value:</b> $5.75"
  end


  #Edit

  test "can update listing" do
    a = Factory(:user)

    sign_in :user, a

    m = ""

    500.times {m+="a"}

    listing = Factory(:listing, :description => m, :user => a )

    m2 = ""

    500.times {m2+="b"}

    put :update, :listing_id => listing.id, :params => { :description => m2 }
    assert_response :success


  end

  test "can't make a listing if not logged in" do 
    get :new
    assert_response :redirect
  end

  test "can make a listing if logged in" do
    a = Factory(:user)

    sign_in :user, a

    get :new
    assert_response :success
  end

end
