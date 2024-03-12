module OmniArticle
  class Admin::Articles::BaseController < Admin::BaseController
    before_action :set_article, :set_article_base_breadcrumbs

    private

      def set_article
        @article = policy_scope([:omni_article, :admin, Article]).find(params[:article_id])
      end

      def set_article_base_breadcrumbs
        add_breadcrumb Article.model_name.human, admin_articles_path
        add_breadcrumb @article.id, admin_article_path(@article)
      end
  end
end
