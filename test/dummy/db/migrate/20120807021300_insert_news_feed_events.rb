class InsertNewsFeedEvents < ActiveRecord::Migration

  def self.up
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

  def self.down
    drop_table :news_feed
  end

end
