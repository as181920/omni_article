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
    end

    test "should show tenant article from owner route as json" do
      get user_tenant_article_path(@tenant.uid, @article.uid), as: :json

      assert_response :success
    end

    test "should render tenant article owner route json fields" do
      get user_tenant_article_path(@tenant.uid, @article.uid), as: :json

      assert_equal @article.uid, @response.parsed_body["uid"]
      assert_equal @article.summary, @response.parsed_body["summary"]
    end

    test "should show organization article from owner route as json" do
      get user_organization_article_path(@organization.uid, @organization_article.uid), as: :json

      assert_response :success
    end

    test "should render organization article owner route json fields" do
      get user_organization_article_path(@organization.uid, @organization_article.uid), as: :json

      assert_equal @organization_article.uid, @response.parsed_body["uid"]
      assert_equal @organization_article.summary, @response.parsed_body["summary"]
    end
  end
end
