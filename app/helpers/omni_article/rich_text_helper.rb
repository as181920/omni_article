module OmniArticle
  module RichTextHelper
    def rich_text_image_upload_url
      {
        "TenantAuth::User" => tenant_auth.shared_image_uploads_path
      }[current_user.class.name]
    end

    def rich_text_image_list_url
      {
        "TenantAuth::User" => tenant_auth.shared_image_uploads_path(format: :json)
      }[current_user.class.name]
    end

    def rich_text_language
      I18n.locale.eql?(:"zh-CN") ? "zh-Hans" : "en"
    end

    def rich_text_language_url
      if I18n.locale.eql?(:"zh-CN")
        javascript_path("easy_style/tinymce.zh-Hans.js")
      else
        ""
      end
    end
  end
end
