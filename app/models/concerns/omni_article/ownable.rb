module OmniArticle
  module Ownable
    extend ActiveSupport::Concern

    included do
      has_many :articles, class_name: "::OmniArticle::Article", as: :owner, dependent: :destroy
    end
  end
end
