require 'test_helper'

class Devise::RegistrationsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test "can see sign up page" do
    get :new
    assert_response :success
  end
  
  
  test "can sign up" do
    assert_difference "User.count", 1 do
      post :create, :user=>{:email=>"bob@example.com", :password=>"123456", :password_confirmation=>"123456"}
    end
    assert_redirected_to root_path
    assert_not_nil flash[:notice]
    assert_equal "bob@example.com", User.last.email
  end
  
  test "can't sign up short password" do
    assert_difference "User.count", 0 do
      post :create, :user=>{:email=>"bob@example.com", :password=>"1234", :password_confirmation=>"1234"}
    end
    assert_response :success
    assert_select "#error_explanation"
  end
  
  test "can't sign up mismatching password" do
    assert_difference "User.count", 0 do
      post :create, :user=>{:email=>"bob@example.com", :password=>"123456", :password_confirmation=>"123457"}
    end
    assert_response :success
    assert_select "#error_explanation"
  end
  
  
  test "can't sign up twice" do
    Factory(:user, :email=>"bob@example.com")
    assert_difference "User.count", 0 do
      post :create, :user=>{:email=>"bob@example.com", :password=>"123456", :password_confirmation=>"123456"}
    end
    assert_response :success
    assert_select "#error_explanation"
  end
  
end