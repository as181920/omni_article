module OmniArticle
  class ExpireSitemapManifestJob < ApplicationJob
    self.enqueue_after_transaction_commit = true

    class << self
      def enqueue_for(article)
        return unless defined?(TenantAuth::Tenant)
        return unless article.destroyed? || article.saved_change_to_owner_type? || article.saved_change_to_owner_id? || article.saved_change_to_uid?

        owners = []
        unless article.destroyed?
          owners << [article.owner_type_before_last_save, article.owner_id_before_last_save]
        end
        owners << [article.owner_type_in_database, article.owner_id_in_database]
        tenant_ids = owners.filter_map { |type, id| id if type == TenantAuth::Tenant.polymorphic_name }.uniq
        perform_later(tenant_ids) if tenant_ids.any?
      end
    end

    def perform(tenant_ids)
      DiscoveryCatalog.expire_sitemap_manifests(tenant_ids)
    end
  end
end
