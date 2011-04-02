class Topic < ActiveRecord::Base
  
  has_many :posts
  belongs_to :forum
  belongs_to :user
  
  accepts_nested_attributes_for :posts
  
  attr_accessible :title, :posts_attributes
  
  validates_presence_of :forum
  validates_presence_of :title
  validates_presence_of :user
  validate :has_post

  def has_post
    errors.add_to_base "Your topic must have some content" if self.posts.blank?
  end
  
  def to_param
    "#{id}-#{title.parameterize}"
  end
  
  
end
