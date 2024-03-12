module OmniArticle
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    def self.policy_class
      "#{name.demodulize}Policy"
    end
  end
end
