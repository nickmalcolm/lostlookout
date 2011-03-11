require 'test_helper'

class ExternalPhotoTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  test "Imgur valid host" do
    ep = ExternalPhoto.create(:listing => Factory(:listing), :raw_url=>"http://imgur.com/XVDz4")
    
    assert ep.save!, "Good site should save"
  end
  
  test "various imgur urls" do
    good_urls = [ "http://imgur.com/XVDz4.jpg", 
                  "http://imgur.com/wq9ab.png", 
                  "http://imgur.com/cheese7.gif", 
                  "http://i.imgur.com/XVDz4.jpg", 
                  "http://i.imgur.com/wq9ab.png", 
                  "http://i.imgur.com/cheese7.gif"]
                  
    good_urls.each do |gu|
      assert ExternalPhoto.create!(:listing => Factory(:listing), :raw_url=>gu), "#{gu} should be OK"
    end
  end
  
  test "random invalid host" do
    begin
      ep = ExternalPhoto.create!(:listing => Factory(:listing), :raw_url=>"http://badsite.com")
    rescue ActiveRecord::RecordInvalid
      #Correct behaviour
      return true
    end
    fail "Bad site should not save"
  end
  
  test "various invalid hosts" do
    bad_urls = ["http://imgur.com.badhost.com/XVDz4.jpg", 
                "imgur.com/XVDz4.png", 
                "http://imgur.com/XVDz4.bmp", 
                "http://i.imgur.com/XVDz4.js", 
                "http://i.imgur.com/XVDz4.txt"]
    bad_urls.each do |bu|
      begin
        ep = ExternalPhoto.create!(:listing => Factory(:listing), :raw_url=>bu)
      rescue ActiveRecord::RecordInvalid
        #Correct behaviour
        next
      end
        fail "#{bu} should not be OK"
    end
    
  end
  
  test "url conversion" do
    ep = ExternalPhoto.create!(:listing => Factory(:listing), :raw_url=>"http://imgur.com/XVDz4")
    assert_equal "http://i.imgur.com/XVDz4", ep.raw_url
    assert_equal "http://i.imgur.com/XVDz4l.jpg", ep.large_url
    assert_equal "http://i.imgur.com/XVDz4s.jpg", ep.small_url
    assert_equal "http://i.imgur.com/XVDz4m.jpg", ep.med_url
  end
    
end
