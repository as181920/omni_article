module OmniArticle
  class User::BaseController < ApplicationController
    include UserAuth::AuthGuard
    include Pundit::Authorization

    layout -> { request.format.html? ? "omni_article/application" : false }

    private

      def check_tenant_state
        return unless respond_to?(:current_tenant, true) && %w[suspended closed].include?(current_tenant&.state)

        redirect_to tenant_auth.billing_path
      end
  end
end
