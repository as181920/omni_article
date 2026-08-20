module OmniArticle
  class Admin::BaseController < ApplicationController
    include Admin::AuthGuard
    include Pundit::Authorization
    include ::TenantAuth::LocaleGuard
    include ::ShortUrl::UrlUtility
    include EasyStyle::AdminLayout
    use_admin_layout "omni_article/admin"
  end
end
