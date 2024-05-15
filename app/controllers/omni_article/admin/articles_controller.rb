module OmniArticle
  class Admin::ArticlesController < Admin::BaseController
    before_action :add_article_index_breadcrumbs
    before_action :set_article, only: %i[show edit update destroy]

    def index
      @q = policy_scope([:omni_article, :admin, Article])
        .then { |scope| params.dig(:q, :s).present? ? scope : scope.order(id: :desc) }
        .ransack(params[:q])
      @articles = @q.result
        .select(:id, :uid, :title, :owner_type, :owner_id, :created_at, :updated_at)
        .page(params[:page]).per(params[:per] || 10)
    end

    def show
      authorize [:omni_article, :admin, @article]
      add_breadcrumb @article.id, [:admin, @article]
    end

    def new
      @article = Article.new
      authorize [:omni_article, :admin, @article]
      add_breadcrumb t("omni_article.new"), %i[new admin article]
    end

    def edit
      authorize [:omni_article, :admin, @article]
      add_breadcrumb t("omni_article.edit"), [:edit, :admin, @article]
    end

    def create
      @article = Article.where(owner: UserAuthService.article_owner(current_user)).new(article_params)
      authorize [:omni_article, :admin, @article]

      if @article.save
        redirect_to [:admin, @article], notice: I18n.t("omni_article.flash.created_successfully")
      else
        redirect_back fallback_location: %i[new admin article], alert: @article.errors.full_messages
      end
    end

    def update
      authorize [:omni_article, :admin, @article]

      if @article.update(article_params)
        redirect_to [:admin, @article], notice: I18n.t("omni_article.flash.updated_successfully")
      else
        redirect_back fallback_location: %i[new admin article], alert: @article.errors.full_messages
      end
    end

    def destroy
      authorize [:omni_article, :admin, @article]

      if @article.destroy
        redirect_to %i[admin articles], notice: I18n.t("omni_article.flash.destroyed_successfully")
      else
        redirect_back fallback_location: [:admin, @article], alert: @article.errors.full_messages
      end
    end

    private

      def add_article_index_breadcrumbs
        add_breadcrumb Article.model_name.human, [:admin, Article]
      end

      def set_article
        @article = Article.find(params[:id])
      end

      def article_params
        params.fetch(:article, {}).permit(
          :title, :template, :content,
          :icon, :tag_list
        ).tap do |permitted_params|
          permitted_params[:tag_list] = permitted_params[:tag_list].to_s.split(/,|;|，|；|\s+/).compact_blank.join(",")
        end
      end
  end
end
