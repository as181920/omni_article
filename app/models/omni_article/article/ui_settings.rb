module OmniArticle
  class Article::UiSettings
    LIST_DISPLAY_STYLE_VALUES = %w[small large].freeze
    BOOLEAN_VALUES = ActiveModel::Type::Boolean.new

    def initialize(custom_settings = {})
      @custom_settings = custom_settings.to_h
    end

    def list_display_style
      @custom_settings.dig("ui", "list_display_style").presence_in(LIST_DISPLAY_STYLE_VALUES) || "small"
    end

    def list_display_style_options
      LIST_DISPLAY_STYLE_VALUES.map do |value|
        [Article.human_attribute_name("list_display_style_values.#{value}"), value]
      end
    end

    def show_history_nav
      BOOLEAN_VALUES.cast(@custom_settings.dig("ui", "show_history_nav"))
    end
  end
end
