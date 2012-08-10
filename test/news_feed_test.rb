require 'test_helper'

class NewsFeedTest < Test::Unit::TestCase
  def test_to_get_user_name
    user = User.new
    assert_equal "Bob Smith", user.object_name
  end

  def test_for_creating_a_new_object
    user_1 = User.create
    current_user = User.create
    message = Message.create
    message.insertNewsFeed(:Create, user_1, current_user)
    news_feed_event = user_1.news_feed_events.last
    assert_equal news_feed_event, NewsFeedEvent.last
    assert_equal news_feed_event.text, 'Bob Smith has created a Message: Message Title'
    assert_equal news_feed_event.event_type_object, 'CreateMessage'
  end

  def test_for_updating_and_sending_self_an_object
    user_1 = User.create
    current_user = User.create
    message = Message.create
    current_user.insertNewsFeed(:Update, current_user, current_user)
    news_feed_event = current_user.news_feed_events.last
    assert_equal news_feed_event.text, 'You have updated a User: Bob Smith'
    assert_equal news_feed_event.event_type_object, 'UpdateUser'
  end

  def test_for_delete_an_object_sent_to_multiple_recipients
    user_1 = User.create
    current_user = User.create
    message = Message.create
    message.insertNewsFeed(:Delete, user_1, current_user)
    news_feed_event = user_1.news_feed_events.last
    assert_equal news_feed_event.text, 'Bob Smith has deleted a Message: Message Title'
    assert_equal news_feed_event.event_type_object, 'DeleteMessage'
  end
  
  def test_for_multiple_news_feeds
    user_1 = User.create
    current_user = User.create
    message = Message.create
    message.insertNewsFeed(:Delete, user_1, current_user)
    message.insertNewsFeed(:Create, user_1, current_user)
    assert_equal user_1.news_feed_events.size, 2
  end

  def test_for_sending_an_object_to_multiple_recipients
    user_1 = User.create
    current_user = User.create
    message = Message.create
    message.insertNewsFeed(:Send, [user_1, current_user], current_user)
    news_feed_event_1 = user_1.news_feed_events.last
    assert_equal news_feed_event_1.text, 'Bob Smith has sent you a Message: Message Title'
    assert_equal news_feed_event_1.event_type_object, 'SendMessage'
    news_feed_event_2 = current_user.news_feed_events.last
    assert_equal news_feed_event_2.text, 'You have sent Bob Smith a Message: Message Title'
  end

  def test_for_sending_an_object_to_multiple_recipients
    user_1 = User.create
    current_user = User.create
    message = Message.create
    message.insertNewsFeed(:Custom, [user_1, current_user], current_user, "This is my custom message!")
    news_feed_event_1 = user_1.news_feed_events.last
    assert_equal news_feed_event_1.text, 'This is my custom message!'
    assert_equal news_feed_event_1.event_type_object, 'CustomMessage'
    news_feed_event_2 = current_user.news_feed_events.last
    assert_equal news_feed_event_2.text, 'This is my custom message!'
  end
end