module OmniArticle
  module DiscoveryCatalog
    class << self
      def scope
        Article.where(owner_type: TenantAuth::Tenant.polymorphic_name, owner_id: TenantAuth::Tenant.with_public_content.select(:id))
      end

      def sitemap_manifest_key(tenant_id)
        "omni_article:sitemap:manifest:v1:#{tenant_id}"
      end

      def expire_sitemap_manifests(tenant_ids)
        Rails.cache.delete_multi(tenant_ids.map { |id| sitemap_manifest_key(id) })
      end

      def sitemap_counts(tenant_ids)
        sitemap_scope(tenant_ids).group(:owner_id).count
      end

      def sitemap_buckets(tenant_ids, size:)
        bucket = Article.arel_table[:id] / Integer(size)
        sitemap_scope(tenant_ids).distinct.pluck(:owner_id, bucket).group_by(&:first)
      end

      def sitemap_rows(tenant_id, size:, bucket: nil)
        records = sitemap_scope(tenant_id).order(:id)
        records = records.where(id: (bucket * size)...((bucket + 1) * size)) if bucket
        records.limit(size + 1).pluck(:id, :uid, :updated_at)
      end

      def sitemap_path(routes, uid)
        routes.discovery_article_path(uid, format: nil)
      end

      def sitemap_prefix(routes)
        sitemap_path(routes, "__uid__").delete_suffix("__uid__")
      end

      private

        def sitemap_scope(tenant_ids)
          scope.where(owner_id: tenant_ids).where.not(uid: [nil, ""])
        end
    end
  end
end
