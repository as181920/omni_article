require "test_helper"

module OmniArticle
  class Admin::ArticleListEntriesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @user = tenant_auth_users(:one)
      sign_in_as(@user)
    end

    test "list heading links to its entry modal" do
      get admin_articles_path

      assert_select "h3 a[href='#{admin_article_list_entry_path}'][data-turbo-frame='modal']" do
        assert_select "svg", count: 1
      end
    end

    test "entry shares the current tenant public list without admin search filters" do
      get admin_article_list_entry_path, params: { tenant_uid: "another-tenant", q: { title_cont: "filtered" } }

      assert_response :success
      assert_equal user_tenant_articles_url(@user.tenant.uid), shared_original_url
      assert_select "turbo-frame#modal img[src^='data:image/png;base64,']", count: 1
    end

    test "entry supports the existing organization article owner" do
      organization = organization_auth_organizations(:one)
      user = OrganizationAuth::User.create!(organization:, name: "article_list_admin", password: "password", root: true)
      UserAuthService.stubs(:session_user).returns(user)

      get admin_article_list_entry_path, headers: { "Turbo-Frame" => "modal" }

      assert_response :success
      assert_equal user_organization_articles_url(organization.uid), shared_original_url
    end

    test "read permission can open the list entry without write permission" do
      TenantAuth::User.any_instance.stubs(:root?).returns(false)
      TenantAuth::User.any_instance.stubs(:has_permission?).with("cms:read", @user.tenant).returns(true)

      get admin_article_list_entry_path

      assert_response :success
    end

    test "entry rejects an administrator without article read permission" do
      TenantAuth::User.any_instance.stubs(:root?).returns(false)
      TenantAuth::User.any_instance.stubs(:has_permission?).returns(false)

      get admin_article_list_entry_path

      assert_response :forbidden
      assert_select "turbo-frame#modal", count: 0
    end

    test "entry requires authentication" do
      sign_out_current
      get omni_article.welcome_index_path

      get admin_article_list_entry_path

      assert_response :unauthorized
    end

    test "turbo modal response omits the full admin layout" do
      get admin_article_list_entry_path, headers: { "Turbo-Frame" => "modal" }

      assert_select "turbo-frame#modal span.copyable-text[data-controller='clipboard']", count: 1
      assert_select "aside", count: 0
    end

    private

      def shared_original_url
        short_url = css_select(".copyable-text [data-clipboard-target='source']").sole.text
        ShortUrl::ShortenerService.fetch(URI.parse(short_url).path.split("/").last)
      end
  end
end
