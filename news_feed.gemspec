$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "news_feed/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "news_feed"
  s.version     = NewsFeed::VERSION
  s.authors     = ["David Leung"]
  s.email       = ["davleun@gmail.com"]
  s.homepage    = ""
  s.summary     = "Creates notification and text messages for users and other objects."
  s.description = "This gems allow for the simple creation of news feed notification objection attached to any class"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.3"
end
