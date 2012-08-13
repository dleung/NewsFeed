# NewsFeed

[![Build Status](https://secure.travis-ci.org/dleung/NewsFeed.png)](http://travis-ci.org/dleung/NewsFeed)

This module will allow users to send and receive NewsFeed notifications to any class object, like a user or a company.  It comes default with Create, Update, Delete, Send, event types, but these can be customized.  There is also an option to specify a custom message.  

## Usage
```ruby
message = Message.new
current_user = User.new
recipient = User.new

# Creates a news_feed in the database with text "You have created a Message: Message Title" that is sent to recipient.  
# To get a list of message, just call 'recipient.news_feed_events'.
# The text can be customized, as well as the recipients.
message.insertNewsFeed(:Create, recipient, current_user)

```

## Installation

NewsFeed is developed with Rails 3.2.3.  First, include it in your gemfile:
```console
gem 'news_feed'
```

Run bundle to install it.  Then, you will need to run the generator.

```console
rails generate news_feed
```

### In Migration

Add this migration to your application:

```ruby
def change
  create_table :news_feed_events, :force => true do |t|
    t.text  :text
    t.integer  :event_object_id
    t.string :event_object_type
    t.string :event_type
    t.integer :sender_id
    t.string :sender_type
    t.integer :recipient_id
    t.string :recipient_type
    t.timestamps
  end
end
```


### In Models
Include 'acts_as_news_feedable' in the following models:

1.  Class that you want a list of news_feed_events.
2.  Class that that you want to call news_feed_events on.

**Pass in the news_feed_object_name as a separate definition when defining acts_as_news_feedable.**  The object name will be used to generate the name of the subject, like a user's full name or a message title, per instance.

```ruby
# In both classes you can call either user.news_feed_events or user.insertNewsFeed
class User
  acts_as_news_feedable
  
  def news_feed_object_name
    "Bob Smith"
  end
  
end

class Message
  acts_as_news_feedable
  
  def news_feed_object_name
    "Message Title"
  end
end
```

### In Controllers
You can get the newsfeed for each acts_as_news_feedable class simply by typing:  
```ruby
@news_feeds = current_user.news_feed_events
```

### In Views
After you set the instance variable, you can use group_by methods and css classes to customize the view and layout of the news feed.  For example, you can create a separate icon for each event_type, and use the object_id to generate a link to that object of interest.

# Adding custom messages and en_news_feed.yml
You can add define and customize additional event messages in the lib/news_feed/news_feed_events.rb.  Editing the messages themselves can be done in config/locales/en.news_feed.rb.  

# References
1.  [Default News Feed Events Samples](https://github.com/dleung/NewsFeed/wiki/Default-News-Feed-Event-Samples)

2.  [Content of latest en_news_feed.yml (0.0.6)](https://github.com/dleung/NewsFeed/wiki/Latest-en_news_feed-file)

3.  [Content of latest news_feed_events.rb (0.0.6)]
(https://github.com/dleung/NewsFeed/wiki/Latest-news_feed_events)

# Translating the messages
Simple add the corresponding translation in the locales file.