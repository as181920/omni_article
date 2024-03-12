require "test_helper"

module OmniArticle
  class User::ArticlesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @article = omni_article_articles(:one)
    end

    test "should show article" do
      get user_article_path(@article.uid)

      assert_response :success
      assert_includes @response.body, @article.title
      # TODO: check rich text content
    end

    test "should show blank page when article not exist" do
      get user_article_path("some_unknown_uid")

      assert_response :success
      assert_includes @response.body, I18n.t("omni_article.not_exist")
    end
  end
end
