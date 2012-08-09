require "test_helper"

class NewsFeedGeneratorTest < Rails::Generators::TestCase
  tests NewsFeedGenerator
  destination File.expand_path("../../tmp", __FILE__)
  setup :prepare_destination
  
  test "Assert all files are properly created" do
    run_generator
    assert_file "config/locales/en_news_feed.yml"
    assert_file "lib/news_feed/news_feed_events.rb"
  end
end