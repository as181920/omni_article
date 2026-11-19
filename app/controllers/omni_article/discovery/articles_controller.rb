module OmniArticle
  class Discovery::ArticlesController < ApplicationController
    def show
      response.headers["Vary"] = "Accept"
      no_store
      return head :not_found unless defined?(TenantAuth::Discovery) && TenantAuth::Discovery.platform_host?(request.host)

      @article = DiscoveryCatalog.scope.find_by(uid: params[:uid])
      return head :not_found unless @article

      @title = @article.title.presence || @article.uid
      @content = ReadableContent.new(@article.content)
      @summary = ReadableContent.new(@article.summary).plain_text
      @canonical_url = discovery_article_url(@article.uid, format: nil, **TenantAuth::Discovery.url_options)
      respond_to do |format|
        format.html { render layout: false }
        format.md { render layout: false }
      end
    end
  end
end
