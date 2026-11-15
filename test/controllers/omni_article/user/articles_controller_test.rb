require "test_helper"

module OmniArticle
  class User::ArticlesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @article = omni_article_articles(:one)
    end

    test "wechat sharing preserves the title without letting it close the script" do
      title = %q{Quote "</script><script>alert(1)</script>&}
      @article.update!(title:)
      official_account = stub
      platform = stub(official_accounts: stub(find_by: official_account))
      WechatOpenPlatformProxy::ThirdPartyPlatform.stubs(:find_by).returns(platform)
      WechatOpenPlatformProxy::OfficialAccountJssdkService.stubs(:new).with(official_account).returns(stub(config: {}))
      get user_article_path(@article.uid), headers: { "User-Agent" => "Mozilla/5.0 MicroMessenger/8.0" }
      source = css_select("script[type=module]").find { |script| script.text.include?("const shareData") }.text
      sharing = JSON.parse(source.match(/const shareData = (.+);/)[1])

      assert_equal title, sharing.fetch("title")
      refute_includes source, "</script>"
    end

    test "should show article" do
      get user_article_path(@article.uid)

      assert_response :success
      assert_select "head title", content: @article.title
      assert_includes @response.body, @controller.view_context.render_rich_text(@article.content)
    end

    test "should render history nav when enabled" do
      @article.update!(custom_settings: @article.custom_settings.deep_merge("ui" => { "show_history_nav" => "1" }))

      get user_article_path(@article.uid)

      assert_includes @response.body, "omni-article-history-nav"
      assert_includes @response.body, I18n.t("omni_article.history_back")
      assert_includes @response.body, I18n.t("omni_article.history_forward")
    end

    test "should show article as json" do
      get user_article_path(@article.uid), as: :json

      assert_response :success
    end

    test "should render article json fields" do
      get user_article_path(@article.uid), as: :json

      assert_equal @article.uid, @response.parsed_body["uid"]
      assert_equal @article.summary, @response.parsed_body["summary"]
      assert_equal @article.custom_settings.dig("ui", "list_display_style"), @response.parsed_body["list_display_style"]
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
