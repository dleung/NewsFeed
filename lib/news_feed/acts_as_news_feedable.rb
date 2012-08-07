module NewsFeed
  def self.included(base)
    base.extend ActsAsNewsFeedable
  end
  
  module ActsAsNewsFeedable
    def acts_as_news_feedable(options = {})
      cattr_accessor :object_name
      self.object_name = options[:object_name]
      
      has_many :news_feed_events, foreign_key: 'recipient_id', dependent: :delete_all
      
      include NewsFeedInstanceMethods
      include NewsFeedEvents
    end
  end

  module NewsFeedInstanceMethods
    def insertNewsFeed(event_name, recipients, actor, options = {})
      if !recipients.is_a?(Array)
        recipients = [recipients]
      end
      recipients.each do |recipient|

        if actor.object_name.blank?
          raise "Actor name must be specified in the model"
        end

        if self.object_name.present?
          object_title =  self.object_name 
        end
        text = generate_text(event_name, actor_name(actor, recipient), object_class, 
        object_title, recipient_name(actor, recipient))
        
        options = {
          text: text,
          object_type: self.class.name,
          object_id: self.id,
          event_type: event_name,
          sender_id: actor.id,
          sender_type: actor.class.name,
          recipient_id: recipient.id,
          recipient_type: recipient.class.name
        }
        NewsFeedEvent.create!(options)
      end
    end
    
    def actor_name(actor,recipient)
      if actor == recipient
        "You have"
      else
        actor.object_name.to_s + " has"
      end      
    end
    
    def recipient_name(actor,recipient)
      if recipient != actor
        "you"
      else
        recipient.object_name.to_s
      end
    end
    
    def object_class
      self.class.name
    end
  end
  
end
 
ActiveRecord::Base.send :include, NewsFeed