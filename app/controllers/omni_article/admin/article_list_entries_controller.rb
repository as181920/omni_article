module OmniArticle
  class Admin::ArticleListEntriesController < Admin::BaseController
    def show
      authorize [:omni_article, :admin, Article], :index?
      @owner = UserAuthService.article_owner(current_user)
    end
  end
end
