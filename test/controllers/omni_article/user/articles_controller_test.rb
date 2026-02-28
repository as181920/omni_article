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
      assert_select "head title", content: @article.title
      assert_includes @response.body, @controller.view_context.rich_text_content(@article.content)
    end

    test "should show article as json" do
      get user_article_path(@article.uid), as: :json

      assert_response :success
    end

    test "should render article json fields" do
      get user_article_path(@article.uid), as: :json

      assert_equal @article.uid, @response.parsed_body["uid"]
      assert_equal @article.summary, @response.parsed_body["summary"]
    end

    test "should show blank page when article not exist" do
      get user_article_path("some_unknown_uid")

      assert_response :success
      assert_includes @response.body, I18n.t("omni_article.not_exist")
    end

    test "should check tenant status before show" do
      @article.owner.suspended!

      get user_article_path(@article.uid)

      assert_response :redirect
      assert_redirected_to tenant_auth.billing_path
      assert_nil flash[:alert]
    end

    test "should keep article shortcut route" do
      get article_path(@article.uid)

      assert_response :success
    end

    test "should keep article shortcut route title" do
      get article_path(@article.uid)

      assert_select "head title", content: @article.title
    end
  end
end
