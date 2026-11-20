module OmniArticle
  class Admin::Selections::ArticlesController < Admin::BaseController
    include ::UserAuth::PaginationHeaders

    DEFAULT_PAGE_SIZE = 10
    MAX_PAGE_SIZE = 100

    before_action :authorize_article_list
    before_action :set_article, :check_article_presence, only: :show
    after_action -> { append_pagination_headers(@articles) }, only: :index

    def index
      term = params[:q].is_a?(String) ? params[:q].squish.first(160) : ""
      per = params[:per].to_s.to_i
      @articles = matching_articles(term).select(:id, :uid, :title).order(updated_at: :desc, id: :desc)
        .page(params[:page]).per(per.positive? ? [per, MAX_PAGE_SIZE].min : DEFAULT_PAGE_SIZE)
    end

    def show; end

    private

      def authorize_article_list
        authorize [:omni_article, :admin, Article], :index?
      end

      def set_article
        @article = articles.find_by(uid: params[:uid])
      end

      def matching_articles(term)
        scope = articles
        return scope if term.blank?

        matches = scope.ransack(title_i_cont: term).result.or(scope.where(uid: term))
        term.match?(/\A\d{1,18}\z/) ? matches.or(scope.where(id: term)) : matches
      end

      def articles
        policy_scope([:omni_article, :admin, Article])
      end
  end
end
