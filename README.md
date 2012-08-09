# NewsFeed

[![Build Status](https://secure.travis-ci.org/dleung/NewsFeed.png)](http://travis-ci.org/dleung/NewsFeed)

This module will allow users to send and receive NewsFeed activities related to actions that are either predefined or custom-created.

## Usage
For example:  A news feed item is generated for creating a message
```
message.insertNewsFeed(Create, user_1, current_user)
# Creates a news_feed in the database with text "Bob Smith has created a Message" that is sent to user_1.  
# The text can be customized, as well as the recipients.
```

## Installation

NewsFeed is developed with Rails 3.2.3.  You can include it in your gemfile:
```
gem 'news_feed'
```

Run bundle to install it.  Then, you will need to run the generator:

```console
rails generate news_feed
```

### In Migration

Add this migration to your application:

```
create_table :news_feed_events, :force => true do |t|
  t.text  :text
  t.integer  :event_object_id
  t.string :event_object_type
  t.string :event_type
  t.integer :sender_id
  t.integer :sender_type
  t.integer :recipient_id
  t.string :recipient_type
  t.timestamps
end
```


### In Models
In the model of interest, add 'acts_as_news_feedable' along with the object name.  The object name will be used to generate the name of the subject, like a user's full name or a message title.

```
class User
  acts_as_news_feedable object_name: "Bob Smith"
end

class Message
  acts_as_news_feedable object_name: "Message Title"
end
```

### In Controllers
The recipients own the news feed events.  You can get the newsfeed for each acts_as_news_feedable recipient simply by typing:  
```
@news_feeds = current_user.news_feed_events
```

### In Views
After you set the instance variable, you can use group_by methods and css classes to customize the view and layout of the news feed.  For example, you can create a separate icon for each event_type, and use the object_id to generate a link to that object of interest.

# Adding custom messages
You can add define and customize additional event messages in the lib/news_feed/news_feed_events.rb.  Editing the messages themselves can be done in config/locales/en.news_feed.rb.  

# Translating the messages
Simple add the corresponding translation in the locales file.