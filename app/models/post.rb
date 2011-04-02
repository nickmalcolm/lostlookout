class Post < ActiveRecord::Base
  
  belongs_to :topic
  belongs_to :user
  
  validates_presence_of :user
  validates_presence_of :topic
  validates_presence_of :content
  
  attr_accessible :content, :topic, :user
  
end
