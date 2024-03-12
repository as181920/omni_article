require "pundit"
require "base58"
require "addressable/uri"

module OmniArticle
  class Engine < ::Rails::Engine
    isolate_namespace OmniArticle

    initializer :append_migrations do |app|
      unless app.root == root.join("test/dummy")
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

    initializer "omni_article.assets.precompile" do |app|
      app.config.assets.precompile += %w[
        omni_article_manifest.js
      ]
    end

    config.to_prepare do
      Dir.glob(OmniArticle::Engine.root.join("app/extensions/**/*_extension*.rb")).each do |c|
        require_dependency c
      end

      # OrganizationAuth::PermissionGroup[:easy_promotion] = %w[
      #   filler:read filler:write
      # ]
    end

    config.generators do |g|
      g.orm             :active_record
      g.template_engine :erb
      g.stylesheets     false
      g.javascripts     false
      g.helper          false
      g.test_framework  :test_unit
      g.skip_routes     true
    end
  end
end
