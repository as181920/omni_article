require "test_helper"

module OmniArticle
  class ApiDocsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get api docs index" do
      get api_docs_path

      assert_response :success
      assert_includes @response.body, openapi_spec_path
    end

    test "should get openapi spec json" do
      get openapi_spec_path

      assert_response :success
      assert_equal "./openapi/paths/user_articles_show.json", @response.parsed_body.dig("paths", "/user/articles/{uid}", "$ref")
      assert_equal "./openapi/paths/shortcut_article_show.json", @response.parsed_body.dig("paths", "/{uid}", "$ref")
    end

    test "should get openapi path file" do
      get openapi_spec_file_path(path: "paths/user_tenant_articles.json")

      assert_response :success
      assert_equal "Tenant article list for mini-program or H5 user side", @response.parsed_body.dig("get", "summary")
    end
  end
end
