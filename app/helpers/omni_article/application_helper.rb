module OmniArticle
  module ApplicationHelper
    def article_list_url(owner)
      case owner
      when TenantAuth::Tenant
        user_tenant_articles_url(owner.uid)
      when OrganizationAuth::Organization
        user_organization_articles_url(owner.uid)
      else
        raise ActiveRecord::RecordNotFound
      end
    end
  end
end
