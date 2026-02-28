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
        raise ActiveRecord::RecordNotFound if owner_uid_key.blank?

        @article_owner = owner_model.find_by!(uid: params[owner_uid_key])
      end

      def article_owner
        @article_owner
      end

      def current_tenant
        @article_owner if @article_owner.is_a?(::TenantAuth::Tenant)
      end
  end
end
