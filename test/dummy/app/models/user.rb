class User < ActiveRecord::Base
  acts_as_news_feedable
  
  def news_feed_object_name
    self.name
  end
  
  attr_accessible :name
 
end
