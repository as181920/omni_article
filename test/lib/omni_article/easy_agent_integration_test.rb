require "test_helper"

module OmniArticle
  class EasyAgentIntegrationTest < ActiveSupport::TestCase
    class EasyAgentProvider
      attr_reader :registration

      def register_tool(tool_class, **options)
        @registration = [tool_class, options]
      end
    end

    test "registers article search as a user tool" do
      provider = EasyAgentProvider.new

      EasyAgentIntegration.install(provider)

      assert_equal SearchArticlesTool, provider.registration[0]
      assert_equal :user, provider.registration[1][:scope]
      assert_equal "omni_article.search_articles", provider.registration[1][:key]
    end
  end
end
