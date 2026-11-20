module OmniArticle
  class Discovery::ArticlesController < ApplicationController
    before_action :set_article

    def show
      @title = @article.title.presence || @article.uid
      @content = ReadableContent.new(@article.content)
      @summary = ReadableContent.new(@article.summary).plain_text
      @canonical_url = discovery_article_url(@article.uid, format: nil, **TenantAuth::Discovery.url_options)
      respond_to do |format|
        format.html { render layout: false }
        format.md { render layout: false }
        format.json
      end
    end

    private

      def set_article
        @article = DiscoveryCatalog.scope.find_by(uid: params[:uid]) if defined?(TenantAuth::Discovery)
        head :not_found unless @article
      end
  end
end
