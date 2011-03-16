class Topic < ActiveRecord::Base
  
  has_many :posts
  belongs_to :forum
  belongs_to :user
  
  validates_presence_of :forum
  validates_presence_of :title
  validates_presence_of :text
  validates_presence_of :user

  def has_post?
    errors.add_to_base "You must have a Post to create a Topic" if self.posts.blank?
  end
  
  
end
