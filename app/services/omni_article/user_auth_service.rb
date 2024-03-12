module OmniArticle
  module UserAuthService
    SUPPORTED_AUTH_TYPES = %w[PlainUserCode PlainUserToken].freeze

    SUPPORTED_USER_CREDENTIALS = [
      ::TenantAuth::User::Credential,
      ::OrganizationAuth::User::Credential
    ].freeze

    SESSION_KEY_USER_TYPE_MAPPING = {
      org_user_id: "OrganizationAuth::User",
      tnt_user_id: "TenantAuth::User",
      usr_user_id: "UserAuth::User"
    }.freeze

    USER_TYPE_OWNER_METHOD_MAPPING = {
      "TenantAuth::User" => :tenant,
      "AgentAuth::User" => :agent,
      "OrganizationAuth::User" => :organization,
      "NilClass" => :itself
    }.freeze

    InvalidAuthTypeError = Class.new(StandardError)
    InvalidAuthValueError = Class.new(StandardError)

    module_function

    def session_user(session_info = {})
      SESSION_KEY_USER_TYPE_MAPPING.lazy
        .map { |session_key, user_model| session_info[session_key.to_s]&.then { |id| user_model.safe_constantize&.find_by(id:) } }
        &.find(&:present?)
    end

    def authenticate_user(auth_params)
      raise(InvalidAuthTypeError, "auth type not supported.") if SUPPORTED_AUTH_TYPES.exclude?(auth_params[:type])

      send(:"authenticate_using_#{auth_params[:type].underscore}", auth_params[:value])
    end

    def authenticate_using_plain_user_code(code)
      SUPPORTED_USER_CREDENTIALS.lazy
        .map { |credential_class| credential_class.find_by(code:)&.tap(&:regenerate_code) }
        .find(&:present?)
        &.user
    end

    def authenticate_using_plain_user_token(token)
      SUPPORTED_USER_CREDENTIALS.lazy
        .map { |credential_class| credential_class.find_by(token:) }
        .find(&:present?)
        &.user
    end

    def article_owner(user = nil)
      user&.public_send(USER_TYPE_OWNER_METHOD_MAPPING.detect { |type, _| user.class.name.eql?(type) }&.dig(1) || :itself) # rubocop:disable Style/ClassEqualityComparison
    end
  end
end
