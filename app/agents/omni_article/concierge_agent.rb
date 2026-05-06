module OmniArticle
  class ConciergeAgent < RubyLLM::Agent
    attr_reader :context

    inputs :context

    tools do
      [SearchArticlesTool.new(context:)]
    end

    instructions do
      scope = context.scope
      scope_name = scope.respond_to?(:name) ? scope.name : scope.to_s.presence

      I18n.t(
        "omni_article.agents.concierge.instructions",
        scope_name: scope_name || I18n.t("omni_article.agents.concierge.default_scope_name")
      )
    end

    def initialize(context:, **options)
      @context = context
      super(context:, **options)
    end
  end
end
