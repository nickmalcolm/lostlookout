class Forum < ActiveRecord::Base
  
  has_many :topics
  has_many :posts, :through => :topics
  
  def to_param
    "#{id}-#{title.parameterize}"
  end
  
end
