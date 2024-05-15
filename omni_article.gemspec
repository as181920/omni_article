require_relative "lib/omni_article/version"

Gem::Specification.new do |spec|
  spec.name        = "omni_article"
  spec.version     = OmniArticle::VERSION
  spec.authors     = ["Andersen Fan"]
  spec.email       = ["as181920@gmail.com"]
  spec.homepage    = "https://gitlab.dd-life.com/shared/omni_article"
  spec.summary     = "Common article management for rails"
  spec.description = "Simpe article writing and editing"
  spec.license     = "MIT"
  spec.required_ruby_version = ">= 3.2"

  spec.metadata["allowed_push_host"] = "https://gemspec.dd-life.com"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://gitlab.dd-life.com/shared/omni_article"
  spec.metadata["changelog_uri"] = "https://gitlab.dd-life.com/shared/omni_article"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "acts-as-taggable-on", "~> 10.0"
  spec.add_dependency "addressable"
  spec.add_dependency "base58"
  spec.add_dependency "breadcrumbs_on_rails"
  spec.add_dependency "browser"
  spec.add_dependency "jbuilder"
  spec.add_dependency "kaminari"
  spec.add_dependency "pundit"
  spec.add_dependency "rails", ">= 7.1"
  spec.add_dependency "ransack"
end
