class Device < ActiveRecord::Base
  
  validates :apid, :presence => true
  validates :city, :presence => true
  
end
