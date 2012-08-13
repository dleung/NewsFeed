module NewsFeed
  def self.included(base)
    base.extend ActsAsNewsFeedable
  end
  

  module ActsAsNewsFeedable
    def acts_as_news_feedable
      has_many :news_feed_events, foreign_key: 'recipient_id', dependent: :delete_all
      include NewsFeedInstanceMethods
      require Rails.root.join('lib/news_feed/news_feed_events')
      include NewsFeedEvents
    end
  end

  module NewsFeedInstanceMethods
    def insertNewsFeed(event_name, recipients, actor, options = {})
      if !recipients.is_a?(Array)
        recipients = [recipients]
      end
      recipients.each do |recipient|

        unless self.respond_to?('news_feed_object_name')
          raise "news_feed_object_name must be defined in model"
        end

        if self.news_feed_object_name.present?
          object_title =  self.news_feed_object_name 
        end
        
        text = generate_text(event_name, actor_name(actor, recipient), object_class, 
        object_title, recipient_name(actor, recipient), options)
        event_options = {
          text: text,
          event_object_type: self.class.name,
          event_object_id: self.id,
          event_type: event_name,
          sender_id: actor.id,
          sender_type: actor.class.name,
          recipient_id: recipient.id,
          recipient_type: recipient.class.name
        }
        NewsFeedEvent.create!(event_options)
      end
    end
    
    def actor_name(actor,recipient)
      if actor == recipient
        "You have"
      else
        actor.news_feed_object_name.to_s + " has"
      end      
    end
    
    def recipient_name(actor,recipient)
      if recipient != actor
        "you"
      else
        "yourself"
      end
    end
    
    def object_class
      self.class.name
    end
  end
  
end
 
ActiveRecord::Base.send :include, NewsFeed