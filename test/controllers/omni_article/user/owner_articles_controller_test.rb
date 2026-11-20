require "test_helper"

module OmniArticle
  class User::OwnerArticlesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @article = omni_article_articles(:one)
      @organization_article = omni_article_articles(:two)
      @tenant = tenant_auth_tenants(:one)
      @organization = organization_auth_organizations(:one)
    end

    test "should get tenant article index" do
      get user_tenant_articles_path(@tenant.uid)

      assert_response :success
    end

    test "should render tenant article index fields" do
      get user_tenant_articles_path(@tenant.uid)

      assert_includes @response.body, @article.title
      assert_includes @response.body, @article.summary
      assert_not_includes @response.body, @organization_article.title
    end

    test "should filter tenant article index by tag" do
      @article.update!(tag_list: "news")
      @organization_article.update!(tag_list: "platform")

      get user_tenant_articles_path(@tenant.uid), params: { tag: "news" }

      assert_response :success
    end

    test "should render filtered tenant article index by tag" do
      @article.update!(tag_list: "news")
      @organization_article.update!(tag_list: "platform")

      get user_tenant_articles_path(@tenant.uid), params: { tag: "news" }

      assert_includes @response.body, @article.title
      assert_not_includes @response.body, @organization_article.title
    end

    test "should get tenant article index as json" do
      get user_tenant_articles_path(@tenant.uid), as: :json

      assert_response :success
    end

    test "should render tenant article index json fields" do
      get user_tenant_articles_path(@tenant.uid), as: :json

      assert_equal @article.uid, @response.parsed_body.dig(0, "uid")
      assert_equal @article.summary, @response.parsed_body.dig(0, "summary")
      assert_equal @article.custom_settings.dig("ui", "list_display_style"), @response.parsed_body.dig(0, "list_display_style")
    end

    test "should get organization article index" do
      get user_organization_articles_path(@organization.uid)

      assert_response :success
    end

    test "should render organization article index fields" do
      get user_organization_articles_path(@organization.uid)

      assert_includes @response.body, @organization_article.title
      assert_not_includes @response.body, @article.title
    end

    test "should get organization article index as json" do
      get user_organization_articles_path(@organization.uid), as: :json

      assert_response :success
    end

    test "should render organization article index json fields" do
      get user_organization_articles_path(@organization.uid), as: :json

      assert_equal @organization_article.uid, @response.parsed_body.dig(0, "uid")
      assert_equal @organization_article.summary, @response.parsed_body.dig(0, "summary")
      assert_equal @organization_article.custom_settings.dig("ui", "list_display_style"), @response.parsed_body.dig(0, "list_display_style")
    end

    test "tenant article JSON serves original content to visitors" do
      original_content = '<table style="width: 4000px"><tr><td>Value</td></tr></table><form>Hidden</form>'
      @article.update!(content: original_content)

      get user_tenant_article_path(@tenant.uid, @article.uid), as: :json

      assert_response :success
      assert_equal original_content, response.parsed_body.fetch("content")
    end

    test "should render tenant article owner route json fields" do
      get user_tenant_article_path(@tenant.uid, @article.uid), as: :json

      assert_equal @article.uid, @response.parsed_body["uid"]
      assert_equal @article.summary, @response.parsed_body["summary"]
      assert_equal @article.custom_settings.dig("ui", "list_display_style"), @response.parsed_body["list_display_style"]
    end

    test "article JSON is scoped to the requested owner" do
      [@organization_article.uid, "missing"].each do |uid|
        get user_tenant_article_path(@tenant.uid, uid), as: :json

        assert_response :not_found
        assert_equal({ "error" => { "message" => I18n.t("omni_article.article_not_found") } }, response.parsed_body)
      end
    end

    test "an unresolved article shows the existing unavailable page with a not found status" do
      get user_tenant_article_path(@tenant.uid, @organization_article.uid)

      assert_response :not_found
      assert_includes response.body, I18n.t("omni_article.not_exist")
    end

    test "should show organization article from owner route as json" do
      get user_organization_article_path(@organization.uid, @organization_article.uid), as: :json

      assert_response :success
    end

    test "should render organization article owner route json fields" do
      get user_organization_article_path(@organization.uid, @organization_article.uid), as: :json

      assert_equal @organization_article.uid, @response.parsed_body["uid"]
      assert_equal @organization_article.summary, @response.parsed_body["summary"]
      assert_equal @organization_article.custom_settings.dig("ui", "list_display_style"), @response.parsed_body["list_display_style"]
    end
  end
end
