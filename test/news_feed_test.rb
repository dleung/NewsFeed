require 'test_helper'

class NewsFeedTest < Test::Unit::TestCase
  def test_to_get_user_name
    user = User.new
    assert_equal "Bob Smith", user.object_name
  end

  def test_for_defining_insert_news_feed
    user_1 = User.new
    current_user = User.new
    message = Message.new
    message.insertNewsFeed(:Create, user_1, current_user)
  end
end