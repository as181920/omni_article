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
      assert_select "div.modal-overlay[data-controller='modal'] div.modal[data-modal-target='modal'] img[src^='data:image/png;base64,']"
    end
  end
end
