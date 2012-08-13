class Message < ActiveRecord::Base
  acts_as_news_feedable
  
  def news_feed_object_name
    self.title
  end
  
  def title
    "Message Title"
  end 
end
