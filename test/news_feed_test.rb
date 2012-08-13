require 'test_helper'

class NewsFeedTest < Test::Unit::TestCase
  def test_to_get_user_name
    user = User.new(name: 'Bob Smith')
    assert_equal "Bob Smith", user.news_feed_object_name
  end

  def test_for_creating_a_new_object
    user_1 = User.create(name: 'Billy Jones')
    current_user = User.create(name: 'Bob Smith')
    message = Message.create
    message.insertNewsFeed(:Create, user_1, current_user)
    news_feed_event = user_1.news_feed_events.last
    assert_equal news_feed_event, NewsFeedEvent.last
    assert_equal news_feed_event.text, 'Bob Smith has created a Message: Message Title'
    assert_equal news_feed_event.event_type_object, 'CreateMessage'
    assert_equal news_feed_event.event_object_type, 'Message'
    assert_equal news_feed_event.event_type, 'Create'
    assert_equal news_feed_event.sender_id, current_user.id
    assert_equal news_feed_event.sender_type, 'User'
    assert_equal news_feed_event.recipient_id, user_1.id
    assert_equal news_feed_event.recipient_type, 'User'    
    
  end

  def test_for_updating_and_sending_self_an_object
    user_recipient = User.create(name: 'Billy Jones')
    current_user = User.create(name: 'Bob Smith')
    message = Message.create
    current_user.insertNewsFeed(:Update, current_user, current_user)
    news_feed_event = current_user.news_feed_events.last
    assert_equal news_feed_event.text, 'You have updated a User: Bob Smith'
    assert_equal news_feed_event.event_type_object, 'UpdateUser'
    assert_equal news_feed_event.event_object_type, 'User'
    assert_equal news_feed_event.event_type, 'Update'
    assert_equal news_feed_event.sender_id, current_user.id
    assert_equal news_feed_event.sender_type, 'User'
    assert_equal news_feed_event.recipient_id, current_user.id
    assert_equal news_feed_event.recipient_type, 'User'    
  end

  def test_for_delete_an_object_sent_to_multiple_recipients
    user_1 = User.create(name: 'Billy Jones')
    current_user = User.create(name: 'Bob Smith')
    message = Message.create
    message.insertNewsFeed(:Delete, user_1, current_user)
    news_feed_event = user_1.news_feed_events.last
    assert_equal news_feed_event.text, 'Bob Smith has deleted a Message: Message Title'
    assert_equal news_feed_event.event_type_object, 'DeleteMessage'
    assert_equal news_feed_event.event_object_type, 'Message'
    assert_equal news_feed_event.event_type, 'Delete'
    assert_equal news_feed_event.sender_id, current_user.id
    assert_equal news_feed_event.sender_type, 'User'
    assert_equal news_feed_event.recipient_id, user_1.id
    assert_equal news_feed_event.recipient_type, 'User'    
  end
  
  def test_for_multiple_news_feeds
    user_1 = User.create(name: 'Billy Jones')
    current_user = User.create(name: 'Bob Smith')
    message = Message.create
    message.insertNewsFeed(:Delete, user_1, current_user)
    message.insertNewsFeed(:Create, user_1, current_user)
    assert_equal user_1.news_feed_events.size, 2
  end

  def test_for_sending_an_object_to_multiple_recipients
    user_1 = User.create(name: 'Billy Jones')
    current_user = User.create(name: 'Bob Smith')
    message = Message.create
    message.insertNewsFeed(:Send, [user_1, current_user], current_user)
    news_feed_event_1 = user_1.news_feed_events.last
    assert_equal news_feed_event_1.text, 'Bob Smith has sent you a Message: Message Title'
    assert_equal news_feed_event_1.event_type_object, 'SendMessage'
    assert_equal news_feed_event_1.event_object_type, 'Message'
    assert_equal news_feed_event_1.event_type, 'Send'
    assert_equal news_feed_event_1.sender_id, current_user.id
    assert_equal news_feed_event_1.sender_type, 'User'
    assert_equal news_feed_event_1.recipient_id, user_1.id
    assert_equal news_feed_event_1.recipient_type, 'User'
    news_feed_event_2 = current_user.news_feed_events.last
    assert_equal news_feed_event_2.text, 'You have sent yourself a Message: Message Title'
    assert_equal news_feed_event_2.event_type_object, 'SendMessage'
    assert_equal news_feed_event_2.event_object_type, 'Message'
    assert_equal news_feed_event_2.event_type, 'Send'
    assert_equal news_feed_event_2.sender_id, current_user.id
    assert_equal news_feed_event_2.sender_type, 'User'
    assert_equal news_feed_event_2.recipient_id, current_user.id
    assert_equal news_feed_event_2.recipient_type, 'User'
  end

  def test_for_sending_an_object_to_multiple_recipients
    user_1 = User.create(name: 'Billy Jones')
    current_user = User.create(name: 'Bob Smith')
    message = Message.create
    message.insertNewsFeed(:Custom, [user_1, current_user], current_user, "This is my custom message!")
    news_feed_event_1 = user_1.news_feed_events.last
    assert_equal news_feed_event_1.text, 'This is my custom message!'
    assert_equal news_feed_event_1.event_type_object, 'CustomMessage'
    assert_equal news_feed_event_1.event_object_type, 'Message'
    assert_equal news_feed_event_1.event_type, 'Custom'
    assert_equal news_feed_event_1.sender_id, current_user.id
    assert_equal news_feed_event_1.sender_type, 'User'
    assert_equal news_feed_event_1.recipient_id, user_1.id
    assert_equal news_feed_event_1.recipient_type, 'User'
    news_feed_event_2 = current_user.news_feed_events.last
    assert_equal news_feed_event_2.text, 'This is my custom message!'
    assert_equal news_feed_event_2.event_object_type, 'Message'
    assert_equal news_feed_event_2.event_type, 'Custom'
    assert_equal news_feed_event_2.sender_id, current_user.id
    assert_equal news_feed_event_2.sender_type, 'User'
    assert_equal news_feed_event_2.recipient_id, current_user.id
    assert_equal news_feed_event_2.recipient_type, 'User'
  end
  
  def test_for_different_classes
    user_recipient = User.create(name: 'Billy Jones')
    current_user = User.create(name: 'Bob Smith')
    message = Message.create
    user_recipient.insertNewsFeed(:Create, user_recipient, user_recipient)
    news_feed_event_1 = user_recipient.news_feed_events.last
    assert_equal news_feed_event_1.text, 'You have created a User: Billy Jones'
    assert_equal news_feed_event_1.event_type_object, 'CreateUser'
    assert_equal news_feed_event_1.event_object_type, 'User'
    assert_equal news_feed_event_1.event_type, 'Create'
    assert_equal news_feed_event_1.sender_id, user_recipient.id
    assert_equal news_feed_event_1.sender_type, 'User'
    assert_equal news_feed_event_1.recipient_id, user_recipient.id
    assert_equal news_feed_event_1.recipient_type, 'User'
  end
  
  def test_for_various_messages
    user_recipient = User.create(name: 'Billy Jones')
    current_user = User.create(name: 'Bob Smith')
    message = Message.create
    message.insertNewsFeed(:Create, user_recipient, current_user)
    news_feed_event_1 = user_recipient.news_feed_events.last
    assert_equal news_feed_event_1.text, 'Bob Smith has created a Message: Message Title'
    message.insertNewsFeed(:Delete, current_user, current_user)
    news_feed_event_2 = current_user.news_feed_events.last
    assert_equal news_feed_event_2.text, 'You have deleted a Message: Message Title'            
    current_user.insertNewsFeed(:Update, current_user, current_user)
    news_feed_event_3 = current_user.news_feed_events.last
    assert_equal news_feed_event_3.text, 'You have updated a User: Bob Smith'
    message.insertNewsFeed(:Send, [user_recipient, current_user], current_user)
    news_feed_event_4 = user_recipient.news_feed_events.last
    assert_equal news_feed_event_4.text, 'Bob Smith has sent you a Message: Message Title'
    news_feed_event_5 = current_user.news_feed_events.last
    assert_equal news_feed_event_5.text, 'You have sent yourself a Message: Message Title'
    message.insertNewsFeed(:Custom, user_recipient, current_user, "This is my custom message")
    news_feed_event_6 = user_recipient.news_feed_events.last
    assert_equal news_feed_event_6.text, 'This is my custom message'
  end
end