module OmniArticle
  class Article < ApplicationRecord
    include ::OmniComment

    belongs_to :owner, polymorphic: true

    validates_presence_of :content

    before_validation :set_initial_attrs, on: :create

    private
      def set_initial_attrs
        self.uid ||= SecureRandom.base58
      end
  end
end
