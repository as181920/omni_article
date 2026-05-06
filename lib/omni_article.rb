require "omni_article/engine"

module OmniArticle
  def self.easy_agent_agents
    [
      ConciergeAgent
    ]
  end

  def self.easy_agent_tools
    [
      SearchArticlesTool
    ]
  end
end
