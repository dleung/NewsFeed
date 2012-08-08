class NewsFeedGenerator < Rails::Generators::Base  
    source_root File.expand_path('..', __FILE__)
    
    desc "Copies the news feed locale file and news feed event file to your application"
    
    def copy_locale
      copy_file "../../../config/locales/en_news_feed.yml", "config/locales/en_news_feed.yml"
    end
    
    def copy_news_feed_events
      copy_file "../../../lib/news_feed/news_feed_events.rb", "lib/news_feed/news_feed_events.rb"
    end
          
end