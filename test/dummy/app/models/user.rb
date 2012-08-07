class User < ActiveRecord::Base
  acts_as_news_feedable object_name: "Bob Smith"
end
