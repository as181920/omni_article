module OmniArticle
  class Article < ApplicationRecord
    include ::OmniComment::Commentable

    acts_as_taggable_on :tags

    has_one_attached :icon

    belongs_to :owner, polymorphic: true

    validates :content, presence: true

    before_validation :set_initial_attrs, on: :create

    def self.frequent_tag_list_for(owner:, limit: 10)
      return [] if owner.blank?

      where(owner:)
        .joins(:tags)
        .group("tags.name")
        .order(Arel.sql("COUNT(tags.id) DESC"), "tags.name ASC")
        .limit(limit)
        .pluck("tags.name")
    end

    def self.ransackable_attributes(_auth_object = nil)
      %w[id title summary content owner_type owner_id created_at updated_at]
    end

    def self.ransackable_associations(_auth_object = nil)
      %w[tags]
    end

    private

      def set_initial_attrs
        self.uid ||= SecureRandom.base58
      end
  end
end
