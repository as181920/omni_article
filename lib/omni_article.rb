require "omni_article/engine"

module OmniArticle
  def self.easy_agent_agents
    [
      Agents::ConciergeAgent
    ]
  end

  def self.easy_agent_tools
    [
      AgentTools::SearchArticlesTool
    ]
  end
end
