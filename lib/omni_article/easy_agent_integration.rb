module OmniArticle
  module EasyAgentIntegration
    def self.install(easy_agent)
      easy_agent.register_tool(
        OmniArticle::SearchArticlesTool,
        scope: :user,
        key: "omni_article.search_articles"
      )
    end
  end
end
