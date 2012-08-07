class Messages < ActiveRecord::Base
  acts_as_news_feedable object_name: "Message Title"
end
