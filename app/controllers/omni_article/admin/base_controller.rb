module OmniArticle
  class Admin::BaseController < ApplicationController
    include AuthGuard
    include Pundit::Authorization

    layout -> { request.format.html? ? "omni_article/admin" : false }
  end
end