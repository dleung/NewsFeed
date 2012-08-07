class CreateNewsFeed < ActiveRecord::Migration
  def self.up
    create_table :news_feed, :force => true do |t|
      t.text  :text
      t.integer  :object_id
      t.string :object_type
      t.string :event_type
      t.integer :sender_id
      t.datetime :timestamp
    end
  end

  def self.down
    drop_table :news_feed
  end
end
