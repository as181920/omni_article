require "test_helper"

class OmniArticle::ArticleSelectionsTest < ActionDispatch::IntegrationTest
  setup do
    @article = omni_article_articles(:one)
  end

  test "article options match title, UID or ID within the signed-in tenant" do
    other_tenant = TenantAuth::Tenant.create!(name: "Other article tenant", organization: @article.owner.organization)
    OmniArticle::Article.create!(owner: other_tenant, title: @article.title, content: "<p>Other tenant</p>")
    sign_in_as tenant_auth_users(:one)

    [@article.title, @article.uid, @article.id.to_s].each do |term|
      get omni_article.admin_selections_articles_path, params: { q: term }

      assert_response :ok
      assert_equal [{ "id" => @article.id, "uid" => @article.uid, "title" => @article.title }], response.parsed_body
    end
  end

  test "article previews return the original content in JSON" do
    original_content = '<table style="width: 4000px"><tr><td>Example</td></tr></table><form>Private form</form>'
    @article.update!(content: original_content)
    sign_in_as tenant_auth_users(:one)

    get omni_article.admin_selections_article_path(@article.uid)

    assert_equal "application/json", response.media_type
    assert_equal @article.as_json(only: %i[id uid title content]), response.parsed_body
  end

  test "article selection responses use private HTTP revalidation" do
    sign_in_as tenant_auth_users(:one)

    selection_paths.each do |path|
      get path
      validator = response.headers.fetch("ETag")

      assert_equal %w[max-age=0 must-revalidate private], response.headers.fetch("Cache-Control").split(", ").sort

      get path, headers: { "If-None-Match" => validator }

      assert_response :not_modified
    end
  end

  test "article selection pages preserve the owner scope and expose more results" do # rubocop:disable Minitest/MultipleAssertions
    16.times do |index|
      OmniArticle::Article.create!(owner: @article.owner, title: "Paged match #{index}", content: "<p>Article</p>")
    end
    other_tenant = TenantAuth::Tenant.create!(name: "Other article tenant", organization: @article.owner.organization)
    OmniArticle::Article.create!(owner: other_tenant, title: "Paged match outside scope", content: "<p>Article</p>")
    sign_in_as tenant_auth_users(:one)

    assert_queries_match(/SELECT "omni_article_articles"\."id", "omni_article_articles"\."uid", "omni_article_articles"\."title" FROM/) do
      get omni_article.admin_selections_articles_path, params: { q: "Paged match" }
    end

    assert_response :ok
    assert_equal 10, response.parsed_body.size
    assert_equal 10, response.headers.fetch("X-Per-Page").to_i
    assert_equal 16, response.headers.fetch("X-Total-Count").to_i
    assert_equal 2, response.headers.fetch("X-Total-Pages").to_i
    first_uids = response.parsed_body.pluck("uid")

    get omni_article.admin_selections_articles_path, params: { q: "Paged match", page: 2 }

    assert_response :ok
    assert_equal 2, response.headers.fetch("X-Page").to_i
    assert_equal 6, response.parsed_body.size
    assert_empty first_uids & response.parsed_body.pluck("uid")

    get omni_article.admin_selections_articles_path, params: { q: "Paged match", per: 16 }

    assert_response :ok
    assert_equal 16, response.headers.fetch("X-Per-Page").to_i
    assert_equal 1, response.headers.fetch("X-Total-Pages").to_i
    assert_equal 16, response.parsed_body.size
  end

  test "article previews exclude content owned by another tenant" do
    other_tenant = TenantAuth::Tenant.create!(name: "Other article tenant", organization: @article.owner.organization)
    other_article = OmniArticle::Article.create!(owner: other_tenant, title: "Other article", content: "<p>Other tenant</p>")
    sign_in_as tenant_auth_users(:one)

    [other_article.uid, "missing"].each do |uid|
      get omni_article.admin_selections_article_path(uid)

      assert_response :not_found
      assert_equal({ "error" => { "message" => I18n.t("omni_article.article_not_found") } }, response.parsed_body)
    end
  end

  test "article selections require a session or credential" do
    selection_paths.each do |path|
      get path

      assert_response :unauthorized
    end
  end

  test "article selections are limited to the signed-in account's article scope" do
    sign_in_as user_auth_users(:one)

    get omni_article.admin_selections_articles_path

    assert_response :ok
    assert_empty response.parsed_body

    get omni_article.admin_selections_article_path(@article.uid)

    assert_response :not_found
  end

  test "unsupported credential types return unauthorized" do
    get omni_article.admin_selections_articles_path, headers: { "Authorization" => "Bearer unsupported" }

    assert_response :unauthorized
  end

  test "organization staff with CMS read permission can select and preview their organization articles" do
    article = omni_article_articles(:two)
    organization = article.owner
    staff = article_reader_for(organization)
    headers = { "Authorization" => "PlainUserToken #{staff.auth_token}" }

    get omni_article.admin_selections_articles_path, headers: headers

    assert_response :ok
    assert_equal [article.uid], response.parsed_body.pluck("uid")

    get omni_article.admin_selections_article_path(article.uid), headers: headers

    assert_response :ok
  end

  test "organization admins can preview their organization articles only" do
    article = omni_article_articles(:two)
    admin = article.owner.users.create!(name: "organization_article_admin", password: "password", root: true)
    headers = { "Authorization" => "PlainUserToken #{admin.auth_token}" }

    get omni_article.admin_selections_article_path(article.uid), headers: headers

    assert_response :ok
    assert_equal "application/json", response.media_type

    get omni_article.admin_selections_article_path(@article.uid), headers: headers

    assert_response :not_found
  end

  test "tenant staff with CMS read permission can select and preview their tenant articles" do
    tenant = @article.owner
    staff = article_reader_for(tenant)
    headers = { "Authorization" => "PlainUserToken #{staff.auth_token}" }

    selection_paths.each do |path|
      get path, headers: headers

      assert_response :ok
    end
  end

  test "article selections require CMS read permission for non-admin staff" do
    staff = @article.owner.users.create!(name: "article_staff", password: "password", root: false, state: :active)
    headers = { "Authorization" => "PlainUserToken #{staff.auth_token}" }

    selection_paths.each do |path|
      get path, headers: headers

      assert_response :forbidden
    end
  end

  test "an impersonated tenant user cannot use the original administrator's read permission" do
    staff = @article.owner.users.create!(name: "impersonated_article_staff", password: "password", root: false, state: :active)
    sign_in_as tenant_auth_users(:one)
    post tenant_auth.impersonation_path, params: { user_id: staff.id }

    assert_response :redirect
    assert TenantAuth::Impersonation.current.exists?(target_user: staff)

    admin_read_paths.each do |path|
      get path

      assert_response :forbidden
    end
  end

  test "suspending a tenant reader invalidates existing sessions and tokens on all article read endpoints" do
    staff = article_reader_for(@article.owner)
    token = staff.auth_token
    post tenant_auth.iam_sessions_path, params: { session: { name: staff.name, tenant_uid: staff.tenant.uid, password: "password" } }
    get omni_article.admin_selections_article_path(@article.uid)

    assert_response :ok

    staff.suspended!
    admin_read_paths.each do |path|
      get path

      assert_response :unauthorized
    end

    sign_in_as tenant_auth_users(:one)
    admin_read_paths.each do |path|
      get path, headers: { "Authorization" => "PlainUserToken #{token}" }

      assert_response :unauthorized
    end
  end

  test "read-only organization staff can open article pages without write controls" do # rubocop:disable Minitest/MultipleAssertions
    article = omni_article_articles(:two)
    staff = article_reader_for(article.owner)
    post organization_auth.iam_sessions_path, params: { session: { name: staff.name, organization_uid: article.owner.uid, password: "password" } }

    [omni_article.admin_articles_path, omni_article.admin_article_path(article)].each do |path|
      get path

      assert_response :ok
      assert_select "a[href=?]", omni_article.new_admin_article_path, count: 0
      assert_select "a[href=?]", omni_article.edit_admin_article_path(article), count: 0
      assert_select 'input[name="_method"][value="delete"]', count: 0
    end
  end

  private

    def article_reader_for(owner)
      staff = owner.users.create!(name: "article_reader", password: "password", root: false)
      staff.add_role(:reader, owner)
      staff.roles.on(owner).find_by!(name: :reader).add_permission("cms:read")
      staff
    end

    def admin_read_paths
      selection_paths + [omni_article.admin_articles_path, omni_article.admin_article_path(@article)]
    end

    def selection_paths
      [omni_article.admin_selections_articles_path, omni_article.admin_selections_article_path(@article.uid)]
    end
end
