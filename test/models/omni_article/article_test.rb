require "test_helper"

module OmniArticle
  class ArticleTest < ActiveSupport::TestCase
    setup do
      @tenant = tenant_auth_tenants(:one)
    end

    test "should create article for tenant" do
      article = Article.new \
        owner: @tenant,
        content: "FILLER"

      assert article.save
      assert_predicate article.uid, :present?
    end

    test "should acts as taggable on tags" do
      article = omni_article_articles(:one)

      article.tag_list = "abc,def"

      assert article.save
      assert_includes article.tag_list, "abc"
      assert_includes article.tag_list, "def"
    end
  end
end
