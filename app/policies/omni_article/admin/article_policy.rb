module OmniArticle
  class Admin::ArticlePolicy < ApplicationPolicy
    def new?
      true
    end

    def create?
      record.owner == owner
    end

    def show?
      record.owner == owner
    end
    alias_method :edit?, :show?
    alias_method :update?, :edit?

    def destroy?
      record.owner == owner
    end

    class Scope < Scope
      def resolve
        scope.where(owner:)
      end
    end
  end
end
