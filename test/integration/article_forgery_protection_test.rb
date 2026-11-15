require "test_helper"

class OmniArticle::ArticleForgeryProtectionTest < ActionDispatch::IntegrationTest
  include OmniArticle::Engine.routes.url_helpers

  setup do
    @user = tenant_auth_users(:one)
    sign_in_as(@user)
    @previous_protection = OmniArticle::ApplicationController.allow_forgery_protection
    OmniArticle::ApplicationController.allow_forgery_protection = true
    @input = { article: { title: omni_article_articles(:one).title, content: "<p>Content</p>" } }
  end

  teardown do
    OmniArticle::ApplicationController.allow_forgery_protection = @previous_protection
  end

  test "a cookie-authenticated JSON write still requires a CSRF token" do
    assert_no_difference "OmniArticle::Article.count" do
      post admin_articles_path, params: @input, as: :json
    end

    assert_response :unprocessable_content
  end

  test "Basic remains session authentication and cannot bypass CSRF" do
    post admin_articles_path, params: @input, headers: { "Authorization" => "Basic credentials" }, as: :json

    assert_response :unprocessable_content
  end

  test "an explicit valid tenant credential can write without a browser CSRF token" do
    assert_difference "OmniArticle::Article.count", 1 do
      post admin_articles_path, params: @input, headers: { "Authorization" => "PlainUserToken #{@user.auth_token}" }, as: :json
    end

    assert_response :redirect
    assert_equal @user.tenant, OmniArticle::Article.order(:id).last.owner
  end

  test "an invalid explicit credential cannot fall back to the existing session" do
    assert_no_difference "OmniArticle::Article.count" do
      post admin_articles_path, params: @input, headers: { "Authorization" => "PlainUserToken invalid" }, as: :json
    end

    assert_response :unauthorized
  end
end
