module OmniArticle
  class SearchArticlesTool < RubyLLM::Tool
    DEFAULT_LIMIT = 5
    MAX_LIMIT = 10

    description "Search merchant articles by keyword and return concise article references."

    param :query, desc: "User question or keywords for searching merchant articles"
    param :limit, type: "integer", desc: "Maximum article count to return", required: false

    def initialize(context:)
      @context = context
    end

    def execute(query:, limit: DEFAULT_LIMIT)
      return [] if owner.blank?

      article_scope(query)
        .limit(normalized_limit(limit))
        .map { |article| serialize_article(article) }
    end

    private

      attr_reader :context

      def owner
        context.scope
      end

      def article_scope(query)
        Article.where(owner:)
          .then { |scope| apply_query(scope, query) }
          .order(updated_at: :desc, id: :desc)
      end

      def apply_query(scope, query)
        keyword = query.to_s.strip
        return scope if keyword.blank?

        pattern = "%#{ActiveRecord::Base.sanitize_sql_like(keyword)}%"
        scope.where("title ILIKE :pattern OR summary ILIKE :pattern OR content ILIKE :pattern", pattern:)
      end

      def normalized_limit(limit)
        limit.to_i.clamp(1, MAX_LIMIT)
      end

      def serialize_article(article)
        {
          "gid" => article.to_gid.to_s,
          "title" => article.title.to_s,
          "summary" => article.summary.to_s,
          "content_excerpt" => content_excerpt(article)
        }
      end

      def content_excerpt(article)
        ActionView::Base.full_sanitizer.sanitize(article.content.to_s).squish.truncate(240)
      end
  end
end
