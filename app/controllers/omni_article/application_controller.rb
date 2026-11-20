module OmniArticle
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    helper EasyStyle::Engine.helpers

    private

      def check_article_presence
        render_article_not_found unless @article
      end

      def render_article_not_found
        respond_to do |format|
          format.html { render "omni_article/user/articles/blank", status: :not_found }
          format.json { render "omni_article/shared/article_not_found", status: :not_found }
          format.any { head :not_found }
        end
      end
  end
end
