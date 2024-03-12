module OmniArticle
  class ApplicationController < ActionController::Base
    # include Pundit::Authorization
    # include AuthGuard

    protect_from_forgery with: :null_session

    helper EasyStyle::Engine.helpers

    # layout -> { request.format.html? ? "qiniu_storage/admin" : false }
    #

    # private
    #
    #   def default_url_options
    #     uri = URI(ENV.fetch("qiniu_storage_base_url", nil) || ENV.fetch("app_frontend_base_url", nil) || request.url)
    #     { protocol: uri.scheme, host: uri.host, port: uri.port }
    #   end
  end
end
