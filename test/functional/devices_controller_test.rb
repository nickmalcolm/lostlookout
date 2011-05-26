require 'test_helper'

class DevicesControllerTest < ActionController::TestCase
  
  test "can register with apid and area" do
    assert_difference("Device.count", 1) do
      post :register, {:apid=>"1234", :area => "Wellington"}
    end
    assert_response :success
  end
  
  test "register creates valid Device" do
    post :register, {:apid=>"1234", :area => "Wellington"}
    device = Device.last
    assert_equal "1234", device.apid
    assert_equal "Wellington", device.area
  end
  
  test "No dupe " do
    post :register, {:apid=>"1234", :area => "Wellington"}
    
    assert_equal 1, Device.count
    
    post :register, {:apid=>"1234", :area => "Wellington"}
    
    assert_equal 1, Device.count
  end
  
  test "Dupe updates area" do
    post :register, {:apid=>"1234", :area => "Wellington"}
    
    device = Device.last
    assert_equal "Wellington", device.area
    
    post :register, {:apid=>"1234", :area => "Taranaki"}
    
    device.reload
    assert_equal "Taranaki", device.area
  end
  
end
