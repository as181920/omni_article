require "test_helper"

module OmniArticle
  class WelcomeControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get welcome_index_url

      assert_response :success
      assert_equal I18n.t("omni_article.engine"), @response.parsed_body.at("title").content
      assert_equal I18n.t("omni_article.welcome"), @response.parsed_body.at("div.card-text").content
    end
  end
end
