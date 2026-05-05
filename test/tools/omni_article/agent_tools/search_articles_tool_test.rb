require "test_helper"

module OmniArticle
  module AgentTools
    class SearchArticlesToolTest < ActiveSupport::TestCase
      test "searches articles within context scope" do
        owner = tenant_auth_tenants(:one)
        tool = SearchArticlesTool.new(context: context_for(owner))

        results = tool.execute(query: "CONTENT ONE", limit: 5)

        assert_equal 1, results.size
        assert_equal omni_article_articles(:one).to_gid.to_s, results.first.fetch("gid")
        assert_equal "OMNI ARTICLE TITLE ONE", results.first.fetch("title")
      end

      test "does not return articles from another owner" do
        owner = tenant_auth_tenants(:one)
        tool = SearchArticlesTool.new(context: context_for(owner))

        results = tool.execute(query: "CONTENT TWO", limit: 5)

        assert_empty results
      end

      test "limits result count" do
        owner = tenant_auth_tenants(:one)
        Article.create!(owner:, title: "Extra Article", summary: "Extra", content: "Extra article content")
        tool = SearchArticlesTool.new(context: context_for(owner))

        results = tool.execute(query: "article", limit: 1)

        assert_equal 1, results.size
      end

      private

        def context_for(owner)
          Struct.new(:scope).new(owner)
        end
    end
  end
end
