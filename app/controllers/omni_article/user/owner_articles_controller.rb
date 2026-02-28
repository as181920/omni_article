module OmniArticle
  class User::OwnerArticlesController < User::BaseController
    include User::ArticleOwnerContext

    before_action :set_article_owner
    before_action :check_tenant_state
    before_action :set_article, :check_article_presence, only: %i[show]

    def index
      @q = policy_scope([:omni_article, :user, Article])
        .where(owner: article_owner)
        .then { |scope| params[:tag].present? ? scope.tagged_with(params[:tag]) : scope }
        .then { |scope| params.dig(:q, :s).present? ? scope : scope.order(updated_at: :desc, id: :desc) }
        .ransack(params[:q])
      @articles = @q.result.page(params[:page]).per(params[:per] || 10)

      render "omni_article/user/articles/index"
    end

    def show
      authorize [:omni_article, :user, @article]
      render "omni_article/user/articles/show"
    end

    private

      def set_article
        @article = policy_scope([:omni_article, :user, Article]).find_by(uid: params[:uid], owner: article_owner)
      end

      def check_article_presence
        return if @article.present?

        render "omni_article/user/articles/blank"
      end
  end
end
