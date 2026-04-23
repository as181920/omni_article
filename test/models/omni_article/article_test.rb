require "test_helper"

module OmniArticle
  class ArticleTest < ActiveSupport::TestCase
    setup do
      @tenant = tenant_auth_tenants(:one)
      @organization = organization_auth_organizations(:one)
    end

    test "should create article for tenant" do
      article = Article.new \
        owner: @tenant,
        content: "FILLER"

      assert article.save
      assert_predicate article.uid, :present?
    end

    test "ui settings should fallback list display style to small" do
      ui_settings = Article::UiSettings.new

      assert_equal "small", ui_settings.list_display_style
    end

    test "ui settings should read list display style from custom_settings" do
      ui_settings = Article::UiSettings.new("ui" => { "list_display_style" => "large" })

      assert_equal "large", ui_settings.list_display_style
    end

    test "ui settings should fallback show history nav to false" do
      ui_settings = Article::UiSettings.new

      assert_not ui_settings.show_history_nav
    end

    test "ui settings should read show history nav from custom_settings" do
      ui_settings = Article::UiSettings.new("ui" => { "show_history_nav" => "1" })

      assert ui_settings.show_history_nav
    end

    test "should acts as taggable on tags" do
      article = omni_article_articles(:one)

      article.tag_list = "abc,def"

      assert article.save
      assert_includes article.tag_list, "abc"
      assert_includes article.tag_list, "def"
    end

    test "should get frequent tag list for tenant owner" do
      omni_article_articles(:one).update!(tag_list: "news,expo")
      Article.create!(owner: @tenant, content: "FILLER", tag_list: "news,guide")

      assert_equal %w[news expo guide], Article.frequent_tag_list_for(owner: @tenant)
    end

    test "should get frequent tag list for organization owner" do
      omni_article_articles(:two).update!(tag_list: "platform,expo")
      Article.create!(owner: @organization, content: "FILLER", tag_list: "platform,notice")

      assert_equal %w[platform expo notice], Article.frequent_tag_list_for(owner: @organization)
    end
  end
end
