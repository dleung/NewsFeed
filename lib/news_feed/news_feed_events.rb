module NewsFeed
  module NewsFeedEvents
    def generate_text(event_name, actor_name, object_class, object_title, recipient_name = nil)
        # event_name is what the cases will check for
        # actor_name is the user object that performs the action
        # object_class is the class of the object of interest
        # recipient_name can include the recipient name
      
      case event_name
      when :Create
          I18n.t('news_feeds.create_object', actor: actor_name.to_s, object_class: object_class,
          object_name: object_title)
      end
      

    end
  end
  
end