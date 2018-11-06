$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "omni_article/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "omni_article"
  s.version     = OmniArticle::VERSION
  s.authors     = ["Andersen Fan"]
  s.email       = ["as181920@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of OmniArticle."
  s.description = "TODO: Description of OmniArticle."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.1"

  s.add_development_dependency "sqlite3"
end
