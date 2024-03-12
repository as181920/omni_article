module OmniArticle
  class Admin::Articles::EntriesController < Admin::Articles::BaseController
    def show
      authorize [:omni_article, :admin, @article]
    end
  end
end
