module OmniArticle
  module DiscoveryCatalog
    class << self
      def scope
        Article.where(owner_type: TenantAuth::Tenant.polymorphic_name, owner_id: TenantAuth::Tenant.with_public_content.select(:id))
      end

      def sitemap_entries(routes, url_options:)
        scope.order(:id).pluck(:uid, :updated_at).map do |uid, updated_at|
          [routes.discovery_article_url(uid, **url_options), updated_at]
        end
      end
    end
  end
end
