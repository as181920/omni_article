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
      assert_equal({
        "openapi" => "3.1.2",
        "article_ref" => "./openapi/paths/user_articles_show.json",
        "discovery_ref" => "./openapi/paths/discovery_article_show.json",
        "shortcut_ref" => "./openapi/paths/shortcut_article_show.json"
      }, {
        "openapi" => @response.parsed_body["openapi"],
        "article_ref" => @response.parsed_body.dig("paths", "/user/articles/{uid}", "$ref"),
        "discovery_ref" => @response.parsed_body.dig("paths", "/discovery/articles/{uid}", "$ref"),
        "shortcut_ref" => @response.parsed_body.dig("paths", "/{uid}", "$ref")
      })
    end

    test "should get openapi path file" do
      get openapi_spec_file_path(path: "openapi/paths/user_tenant_articles.json")

      assert_response :success
      assert_equal "Tenant article list for mini-program or H5 user side", @response.parsed_body.dig("get", "summary")
    end

    test "serves the article selection API separately from the user spec" do
      get openapi_spec_file_path(path: "admin.json")

      assert_response :ok
      assert_equal "./paths/admin_article_selections.json", response.parsed_body.dig("paths", "/admin/selections/articles", "$ref")
      assert_equal "./paths/admin_article_selection.json", response.parsed_body.dig("paths", "/admin/selections/articles/{uid}", "$ref")
    end
  end
end
