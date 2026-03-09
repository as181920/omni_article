require "test_helper"

module OmniArticle
  class Admin::Articles::EntriesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @user = tenant_auth_users(:one)
      sign_in_as(@user)

      @article = omni_article_articles(:one)
    end

    test "should show admin_articles_entry" do
      get admin_article_entry_path(@article)

      assert_response :success
    end

    test "should render article entry qr code" do
      get admin_article_entry_path(@article)

      assert_select "div.modal-overlay[data-controller='modal'] div.modal[data-modal-target='modal'] img[src^='data:image/png;base64,']"
    end

    test "should render article entry url clipboard block" do
      get admin_article_entry_path(@article)

      assert_select "div[data-controller='clipboard'] span[data-clipboard-target='source'][class*='fw-500']", count: 2
    end

    test "should render article entry uid clipboard source" do
      get admin_article_entry_path(@article)

      assert_select "div[data-controller='clipboard'] span[data-clipboard-target='source']", text: @article.uid, count: 1
    end

    test "should render article entry clipboard copy buttons" do
      get admin_article_entry_path(@article)

      assert_select "div[data-controller='clipboard'] svg[data-clipboard-target='copy'][data-action='click->clipboard#copy']", count: 2
    end
  end
end
