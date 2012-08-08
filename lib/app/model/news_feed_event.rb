class NewsFeedEvent < ActiveRecord::Base
  belongs_to :recipient, :polymorphic => true
  attr_accessible :text, :event_object_id, :event_object_type, :event_type,
    :sender_id, :sender_type, :recipient_id, :recipient_type
  
  validates_presence_of :recipient_id, :recipient_type
end