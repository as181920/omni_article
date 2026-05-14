require "test_helper"

module OmniArticle
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

      assert_equal 1, results.size  # "CONTENT" matches article one, "TWO" does not
      assert_match(/CONTENT ONE/, results.first.fetch("content_excerpt"))
    end

    test "limits result count" do
      owner = tenant_auth_tenants(:one)
      Article.create!(owner:, title: "Extra Article", summary: "Extra", content: "Extra article content")
      tool = SearchArticlesTool.new(context: context_for(owner))

      results = tool.execute(query: "article", limit: 1)

      assert_equal 1, results.size
    end

    test "matches Chinese keyword inside full user sentence" do
      owner = tenant_auth_tenants(:one)
      article = Article.create!(owner:, title: "重组胶原蛋白敷贴", summary: "医用皮肤修复", content: "适合关注胶原蛋白护理的用户")
      tool = SearchArticlesTool.new(context: context_for(owner))

      results = tool.execute(query: "我想补充胶原蛋白有没有推荐", limit: 5)

      assert_includes results.map { |result| result.fetch("gid") }, article.to_gid.to_s
    end

    private

      def context_for(owner)
        Struct.new(:scope).new(owner)
      end
  end
end
