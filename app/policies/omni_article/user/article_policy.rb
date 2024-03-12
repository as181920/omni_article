module OmniArticle
  class User::ArticlePolicy < ApplicationPolicy
    def show?
      true
    end
  end
end
