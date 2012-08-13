# Configure Rails Environment
ENV["RAILS_ENV"] = "test"
$LOAD_PATH.unshift(File.dirname(__FILE__))


require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Creates In-memory database
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
  create_table "messages", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "news_feed", :force => true do |t|
    t.text     "text"
    t.integer  "object_id"
    t.string   "object_type"
    t.string   "event_type"
    t.integer  "sender_id"
    t.datetime "timestamp"
  end

  create_table "news_feed_events", :force => true do |t|
    t.text     "text"
    t.integer  "event_object_id"
    t.string   "event_object_type"
    t.string   "event_type"
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "users", :force => true do |t|
    t.string "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end
end

# Load support files #
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }


# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

# Generators
require "rails/generators/test_case"
require "generators/news_feed/news_feed_generator"
