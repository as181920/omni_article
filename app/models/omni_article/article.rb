module OmniArticle
  class Article < ApplicationRecord
    include ::OmniComment

    belongs_to :owner, polymorphic: true

    validates_presence_of :content
  end
end
