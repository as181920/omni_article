module OmniArticle
  class ReadableContent
    TAGS = %w[a abbr b blockquote br caption code dd del div dl dt em figure figcaption
      h1 h2 h3 h4 h5 h6 hr i img li ol p pre s span strong sub sup table tbody td th thead tr u ul].freeze
    ATTRIBUTES = %w[alt colspan href rowspan scope src title].freeze
    OMITTED = "script, style, template, noscript, form, button, iframe, object, svg, [hidden], [aria-hidden=true], .d-none"

    def initialize(html)
      fragment = Nokogiri::HTML5.fragment(html.to_s)
      fragment.css(OMITTED).remove
      @html = Rails::HTML5::SafeListSanitizer.new.sanitize(fragment.to_html, tags: TAGS, attributes: ATTRIBUTES)
    end

    attr_reader :html

    def self.markdown_text(text)
      ERB::Util.html_escape(text.to_s.squish).gsub(/[\\`*_\[\]]/) { |character| "\\#{character}" }
    end

    def plain_text
      fragment.xpath(".//text()").map(&:text).join(" ").squish
    end

    def headings
      fragment.css("h1, h2, h3, h4, h5, h6").map { |heading| heading.text.squish }.join(" ")
    end

    private

      def fragment
        @fragment ||= Nokogiri::HTML5.fragment(html)
      end
  end
end
