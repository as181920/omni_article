require "test_helper"

module OmniArticle
  class Admin::ArticlesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @user = tenant_auth_users(:one)
      sign_in_as(@user)

      @article = omni_article_articles(:one)
      @owner = @user.tenant
    end

    test "should get index" do
      get url_for(%i[admin articles])

      assert_response :success
      assert_select "a.btn-primary[href='#{new_admin_article_path}']", count: 1
      assert_select "div.table-responsive[data-controller='table-responsive'] table.table[data-table-responsive-target='table']", count: 1
    end

    test "should get new" do
      get url_for(%i[new admin article])

      assert_response :success
      assert_select "form[action='#{admin_articles_path}'] input[type='text'][name='article[title]']", count: 1
      assert_select "textarea[name='article[content]'][data-form-target='richText']", count: 1
    end

    test "should create admin_article" do
      assert_difference "Article.count", 1 do
        post admin_articles_path, params: { article: { content: "FILLER" } }
      end

      record = Article.last

      assert_redirected_to admin_article_path(record)
      assert_equal I18n.t("omni_article.flash.created_successfully"), flash[:notice]
    end

    test "should show article" do
      get admin_article_path(@article)

      assert_response :success
      assert_includes @response.body, @article.title
      assert_includes @response.body, @controller.view_context.rich_text_content(@article.content)
    end

    test "should show article tag list" do
      @article.update tag_list: "abcdef,xxxyyy"

      get admin_article_path(@article)

      assert_includes @response.body, "abcdef"
      assert_includes @response.body, "xxxyyy"
    end

    test "should get edit" do
      get url_for([:edit, :admin, @article])

      assert_response :success
      assert_select "form[action='#{admin_article_path(@article)}'] input[type='text'][name='article[title]']", count: 1, value: @article.title
      assert_select "textarea[name='article[content]'][data-form-target='richText']", value: @article.content, count: 1
    end

    test "should get edit with tag field" do
      get url_for([:edit, :admin, @article])

      assert_select "textarea[name='article[tag_list]'][data-action='form#validateField form#autoGrow form#autoSplit']",
        value: @article.tag_list,
        count: 1
    end

    test "should get edit with icon upload" do
      get url_for([:edit, :admin, @article])

      assert_select "form[action='#{admin_article_path(@article)}'] input[type='file'][name='article[icon]']", count: 1
      assert_select "form[action='#{admin_article_path(@article)}'] input[type='hidden'][name='article[icon]']",
        value: @article.icon.signed_id,
        count: 1
    end

    test "should update article" do
      assert_no_difference "Article.count" do
        patch admin_article_path(@article), params: {
          article: {
            title: "MODIFIED 2",
            content: "<strong>MODIFIED 3</strong>"
          }
        }
      end

      assert_equal I18n.t("omni_article.flash.updated_successfully"), flash[:notice]
      assert_equal "MODIFIED 2", @article.reload.title
    end

    test "should update article tag list" do
      patch admin_article_path(@article), params: { article: { tag_list: "xxxxxx,yyyyyy" } }

      assert_equal %w[xxxxxx yyyyyy], @article.reload.tag_list
    end

    test "should destroy admin_article" do
      assert_difference "Article.count", -1 do
        delete admin_article_path(@article)
      end

      assert_redirected_to admin_articles_path
      assert_equal I18n.t("omni_article.flash.destroyed_successfully"), flash[:notice]
    end
  end
end
