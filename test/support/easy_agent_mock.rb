# Mock EasyAgent — omni_article does not take a hard gem dependency on easy_agent.
# The host app wires them together at runtime.
# Defined once in the test support path and shared across agent tool tests.

module EasyAgent
  class Conversation; end

  class Message
    attr_accessor :role, :content, :thinking

    def initialize(role:, content:, thinking: nil)
      @role = role.to_sym
      @content = content
      @thinking = thinking
    end

    def user?  = @role == :user
    def assistant? = @role == :assistant
    def thinking = @thinking
  end

  class RunService
    class RunOptions
      def initialize(**); end
    end

    def self.call(*); end
  end
end
