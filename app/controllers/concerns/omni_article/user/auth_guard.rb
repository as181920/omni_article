module OmniArticle
  module User::AuthGuard
    extend ActiveSupport::Concern

    InvalidAuthTypeError = Class.new(StandardError)
    InvalidAuthValueError = Class.new(StandardError)
    AuthenticateFailError = Class.new(StandardError)

    included do
      after_action :verify_authorized, except: :index
      after_action :verify_policy_scoped, only: :index

      helper_method :current_user

      rescue_from AuthenticateFailError, InvalidAuthTypeError, InvalidAuthValueError, with: :handle_authenticate_failure
      rescue_from Pundit::NotAuthorizedError, with: :handle_authorize_failure
    end

    module ClassMethods
    end

    private

      # def authenticate
      #   raise AuthenticateFailError, "authenticate failed." if current_user.blank?
      # end

      def current_user
        @current_user ||= nil
      end

      def auth_params
        @auth_params ||= auth_params_from_url || auth_params_from_header
      end

      def auth_params_from_header
        return if request.authorization.blank?

        ActiveSupport::HashWithIndifferentAccess.new.tap { |p| p[:type], p[:value] = request.authorization&.split }.tap do |p|
          raise(InvalidAuthTypeError, "auth type not supported.") if p[:type].blank?
          raise(InvalidAuthValueError, "auth value is blank.") if p[:value].blank?
        end
      end

      def auth_params_from_url
        p_key = %i[auth_code auth_token].detect { |k| params[k].present? }
        { type: { auth_code: "PlainUserCode", auth_token: "PlainUserToken" }[p_key], value: params[p_key] } if p_key.present?
      end

      def handle_authenticate_failure(error)
        respond_to do |format|
          format.html { render plain: "用户认证失败。", status: :unauthorized }
          format.json { render json: { error: { message: "#{error.class.name}: #{error.message}" } }, status: :unauthorized }
        end
      end

      def handle_authorize_failure(_error)
        respond_to do |format|
          format.html { render plain: "权限不足，请联系管理员。", status: :forbidden }
          format.json { head :forbidden }
        end
      end
  end
end
