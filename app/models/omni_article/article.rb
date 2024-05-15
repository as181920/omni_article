module OmniArticle
  class Article < ApplicationRecord
    include ::OmniComment::Commentable

    acts_as_taggable_on :tags

    belongs_to :owner, polymorphic: true

    validates :content, presence: true

    before_validation :set_initial_attrs, on: :create

    def self.ransackable_attributes(_auth_object = nil)
      %w[id title content owner_type owner_id created_at updated_at]
    end

    private

      def set_initial_attrs
        self.uid ||= SecureRandom.base58
      end
  end
end
