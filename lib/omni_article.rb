require "omni_article/engine"

module OmniArticle
  extend ActiveSupport::Concern

  included do
    has_many :articles, class_name: "::OmniArticle::Article", as: :owner, dependent: :destroy
  end
end
