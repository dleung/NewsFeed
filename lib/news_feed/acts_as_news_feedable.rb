module NewsFeed
  def self.included(base)
    base.extend ActsAsNewsFeedable
  end
  
  module ActsAsNewsFeedable
    def acts_as_news_feedable(options = {})
      cattr_accessor :object_name
      self.object_name = options[:object_name]
      
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
        object_title, recipient_name(recipient))
        
        options = {
          text: text,
          object_class: self.class.name,
          object_id: self.id,
          object_type: self.class.name,
          event_type: event_name,
          sender_id: actor.id
        }
        
        NewsFeedEvents.create!(options)
      end
    end
    
    def actor_name(actor,recipient)
      if actor == recipient
        "You have"
      else
        actor.object_name.to_s + " has"
      end      
    end
    
    def recipient_name(recipient)
      if recipient.object_name.blank?
        nil
      else
        recipient.object_name
      end
    end
    
    def object_class
      self.class.name
    end
  end
  
end
 
ActiveRecord::Base.send :include, NewsFeed