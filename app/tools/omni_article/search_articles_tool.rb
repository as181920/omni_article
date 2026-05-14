module OmniArticle
  class SearchArticlesTool < RubyLLM::Tool
    DEFAULT_LIMIT = 5
    MAX_LIMIT = 10

    description "Search merchant articles by short product, service, or article keywords and return concise article references."

    param :query, desc: "Short search keywords. Prefer product/service terms instead of the full user sentence."
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
        keywords = search_terms(query)
        return scope if keywords.blank?

        scope.ransack(title_or_summary_or_content_cont_any: keywords).result
      end

      def search_terms(query)
        query = query.to_s.strip
        return [] if query.blank?

        terms = query.scan(/[[:alnum:]]+|[\p{Han}\p{Katakana}\p{Hiragana}\p{Hangul}]{2,}/)
        terms += cjk_ngrams(terms)
        terms.uniq.first(80).presence || [query]
      end

      def cjk_ngrams(terms)
        terms
          .select { |term| term.match?(/\A[\p{Han}\p{Katakana}\p{Hiragana}\p{Hangul}]+\z/) }
          .flat_map { |term| ngrams(term, min: 2, max: 8) }
      end

      def ngrams(term, min:, max:)
        max = [max, term.length].min

        (min..max).flat_map do |size|
          term.chars.each_cons(size).map(&:join)
        end.uniq
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
