class Post < ActiveRecord::Base
  
  belongs_to :topic
  belongs_to :user
  
  validates_presence_of :title
  validates_presence_of :user
  validates_presence_of :text
  validates_presence_of :topic
  
end
