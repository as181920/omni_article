module OmniArticle
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    helper EasyStyle::Engine.helpers
  end
end
