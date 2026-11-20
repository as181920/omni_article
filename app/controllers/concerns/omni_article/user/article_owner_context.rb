module OmniArticle
  module User::ArticleOwnerContext
    extend ActiveSupport::Concern

    OWNER_UID_KEYS = {
      tenant_uid: ::TenantAuth::Tenant,
      organization_uid: ::OrganizationAuth::Organization
    }.freeze

    included do
      helper_method :article_owner
    end

    private

      def set_article_owner
        owner_uid_key, owner_model = OWNER_UID_KEYS.find { |key, _klass| params[key].present? }
        @article_owner = owner_model&.find_by(uid: params[owner_uid_key])
      end

      def check_article_owner_presence
        render_article_not_found unless @article_owner
      end

      def article_owner
        @article_owner
      end

      def current_tenant
        @article_owner if @article_owner.is_a?(::TenantAuth::Tenant)
      end
  end
end
