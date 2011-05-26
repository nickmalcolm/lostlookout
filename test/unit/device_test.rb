require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "valid with apid and area" do
    assert Device.new(:apid => "1234", :area => "Wellington").valid?
  end
  
  test "invalid with only apid" do
    assert Device.new(:apid => "1234").invalid?
  end
  
  test "invalid with only area" do
    assert Device.new(:area => "Wellington").invalid?
  end
  
  test "no dupes" do
    Device.create!(:apid => "1234", :area => "Wellington")
    assert Device.new(:apid => "1234", :area => "Wellington").invalid?
  end
end
