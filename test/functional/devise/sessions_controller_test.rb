require 'test_helper'

class Devise::SessionsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = Factory(:user, :email => "bob@example.com", :password=>"123456")
  end

  test "can see sign in page" do
    get :new
    assert_response :success
  end
  
  
  test "first sign in redirects to edit" do
    post :create, :user=>{:email=>"bob@example.com", :password=>"123456"}
    assert_redirected_to edit_user_registration_path(@user.id)
    assert_not_nil flash[:notice]
  end
  
  test "subsequent sign in redirects to home" do
    @user.sign_in_count = @user.sign_in_count + 1
    @user.save!
    post :create, :user=>{:email=>"bob@example.com", :password=>"123456"}
    assert_redirected_to root_path
  end
  
  
  test "can't sign in with wrong password" do 
    post :create, :user=>{:email=>"bob@example.com", :password=>"523456"}
    assert_redirected_to new_user_session_path
    assert_not_nil flash[:alert]
  end
  
  test "can't sign in with wrong email" do 
    post :create, :user=>{:email=>"bobr@example.com", :password=>"123456"}
    assert_redirected_to new_user_session_path
    assert_not_nil flash[:alert]
  end
end