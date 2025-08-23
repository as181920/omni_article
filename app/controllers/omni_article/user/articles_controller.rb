module OmniArticle
  class User::ArticlesController < User::BaseController
    before_action :set_article, :check_article_presence, :check_tenant_state, only: %i[show]

    def show
      authorize [:omni_article, :user, @article]
    end

    private

      def set_article
        @article = Article.find_by(uid: params[:uid])
      end

      def current_tenant
        @current_tenant ||= @article&.owner
      end

      def check_article_presence
        return if @article.present?

        render "blank"
      end
  end
end
