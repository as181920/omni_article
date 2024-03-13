module OmniArticle
  class Admin::BaseController < ApplicationController
    include Admin::AuthGuard
    include Pundit::Authorization
    include ::TenantAuth::LocaleGuard
    include ::ShortUrl::UrlUtility

    layout -> { request.format.html? ? "omni_article/admin" : false }
  end
end
