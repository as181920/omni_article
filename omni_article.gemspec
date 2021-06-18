$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "omni_article/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "omni_article"
  s.version     = OmniArticle::VERSION
  s.authors     = ["Andersen Fan"]
  s.email       = ["as181920@gmail.com"]
  s.homepage    = ""
  s.summary     = "Common article management for rails"
  s.description = "Simpe article writing and editing"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 6.1"

  s.add_development_dependency "sqlite3"
end
