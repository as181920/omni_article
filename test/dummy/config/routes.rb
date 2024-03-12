Rails.application.routes.draw do
  # mount UserAuth::Engine => "/user_auth"
  mount TenantAuth::Engine => "/tenant_auth"
  # mount OrganizationAuth::Engine => "/organization_auth"

  mount OmniArticle::Engine => "/omni_article"
end
