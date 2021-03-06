# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120811044708) do

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
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

end
