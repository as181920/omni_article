module OmniArticle
  class Admin::ArticlePolicy < ApplicationPolicy
    def index?
      (!user.respond_to?(:root?) || user.root?) ||
        (!user.respond_to?(:has_permission?) || user.has_permission?("cms:read", user.tenant))
    end

    def new?
      (!user.respond_to?(:root?) || user.root?) ||
        (!user.respond_to?(:has_permission?) || user.has_permission?("cms:write", user.tenant))
    end

    def show?
      (record.owner == owner) &&
        (
          (!user.respond_to?(:root?) || user.root?) ||
          (!user.respond_to?(:has_permission?) || user.has_permission?("cms:read", user.tenant))
        )
    end

    def edit?
      (record.owner == owner) &&
        (
          (!user.respond_to?(:root?) || user.root?) ||
          (!user.respond_to?(:has_permission?) || user.has_permission?("cms:write", user.tenant))
        )
    end
    alias_method :create?, :edit?
    alias_method :update?, :edit?
    alias_method :destroy?, :edit?

    class Scope < Scope
      def resolve
        scope.where(owner:)
      end
    end
  end
end
