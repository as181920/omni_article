require "test_helper"

module OmniArticle
  class ExpireSitemapManifestJobTest < ActiveJob::TestCase
    test "destroy expires the persisted tenant even with an unsaved owner change" do
      article = omni_article_articles(:one)
      tenant = article.owner
      article.owner = tenant.organization

      assert_enqueued_with(job: ExpireSitemapManifestJob, args: [[tenant.id]]) { article.destroy! }
    end
  end
end
