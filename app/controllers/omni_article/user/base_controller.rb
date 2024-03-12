module OmniArticle
  class User::BaseController < ApplicationController
    include User::AuthGuard
    include Pundit::Authorization

    layout -> { request.format.html? ? "omni_article/application" : false }
  end
end
