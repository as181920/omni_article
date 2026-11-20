require "test_helper"

class OmniArticle::ArticleDiscoveryTest < ActionDispatch::IntegrationTest
  setup do
    @previous_frontend_url = ENV["app_frontend_base_url"]
    ENV["app_frontend_base_url"] = "https://platform.example.test"
    host! "platform.example.test"
    @article = omni_article_articles(:one)
    @settings = @article.owner.create_ext_info!(public_content_enabled: true)
  end

  teardown do
    ENV["app_frontend_base_url"] = @previous_frontend_url
  end

  test "serves public articles with a platform canonical URL" do
    path = omni_article.discovery_article_path(@article.uid)

    get path

    assert_response :ok
    assert_select "link[rel='canonical'][href='https://platform.example.test#{path}']"
  end

  test "removes interactive markup from public articles" do
    @article.update!(content: "<p>Public article text</p><form><p>Hidden form text</p></form>")

    get omni_article.discovery_article_path(@article.uid)

    assert_select "article p", text: "Public article text"
    assert_select "article form", count: 0
    refute_includes response.body, "Hidden form text"
  end

  test "negotiates Markdown with the same article URL" do
    get omni_article.discovery_article_path(@article.uid), headers: { "Accept" => "text/markdown" }

    assert_response :ok
    assert_equal "text/markdown", response.media_type
    assert_includes response.body, "# #{@article.title}"
  end

  test "negotiates JSON and preserves only public article content" do # rubocop:disable Minitest/MultipleAssertions
    public_html = '<p><a href="https://example.test/catalog">Public catalog</a></p>'
    @article.update!(summary: "<strong>Public summary</strong>", content: "#{public_html}<form>Hidden form text</form>")
    host! "catalog.example.test"
    path = omni_article.discovery_article_path(@article.uid)

    get path, headers: { "Accept" => "application/json" }

    assert_response :ok
    assert_equal "application/json", response.media_type
    assert_includes response.headers.fetch("Vary").split(/,\s*/), "Accept"
    assert_equal({
      "uid" => @article.uid,
      "updated_at" => @article.updated_at.as_json,
      "title" => @article.title,
      "summary" => "Public summary",
      "canonical_url" => "https://platform.example.test#{path}",
      "content_html" => public_html
    }, response.parsed_body)
  end

  test "the JSON extension follows the same public Discovery scope" do
    path = omni_article.discovery_article_path(@article.uid, format: :json)
    get path

    assert_response :ok
    assert_equal "application/json", response.media_type

    @settings.update!(public_content_enabled: false)
    get path

    assert_response :not_found
  end

  test "withdrawing the tenant's GEO permission immediately hides its articles" do
    @settings.update!(public_content_enabled: false)

    get omni_article.discovery_article_path(@article.uid)

    assert_response :not_found
  end

  test "articles owned by an organization are outside the tenant discovery scope" do
    article = omni_article_articles(:two)

    get omni_article.discovery_article_path(article.uid)

    assert_response :not_found
  end
end
