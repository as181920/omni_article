module OmniArticle
  class Article < ApplicationRecord
    include ::OmniComment

    validates_presence_of :content
  end
end
