module OmniArticle
  class ApiDocsController < ApplicationController
    def index
      @openapi_spec_path = openapi_spec_path
    end

    def openapi
      send_file(
        openapi_root_dir.join("openapi.json"),
        type: "application/json; charset=utf-8",
        disposition: "inline"
      )
    end

    def openapi_file
      relative_path = params[:path].to_s
      if params[:format].present? && File.extname(relative_path).blank?
        relative_path = "#{relative_path}.#{params[:format]}"
      end
      relative_path = Pathname.new(relative_path).cleanpath.to_s
      return head :not_found if relative_path.blank? || relative_path.start_with?("..") || relative_path.include?("\\")

      file_path = openapi_root_dir.join(relative_path).cleanpath
      return head :not_found unless file_path.to_s.start_with?("#{openapi_root_dir}/")
      return head :not_found unless File.file?(file_path)

      send_file file_path, type: detect_content_type(file_path), disposition: "inline"
    end

    private

      def openapi_root_dir
        OmniArticle::Engine.root.join("config/openapi")
      end

      def detect_content_type(file_path)
        case File.extname(file_path.to_s)
        when ".json"
          "application/json; charset=utf-8"
        when ".yaml", ".yml"
          "application/yaml; charset=utf-8"
        else
          "text/plain; charset=utf-8"
        end
      end
  end
end
