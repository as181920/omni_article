ENV_CONFIG = Rails.root.join("config/local_env.yml").then do |env_file|
  File.readable?(env_file) ? Hash(YAML.load_file(env_file, aliases: true)[Rails.env]) : {}
end

class ENVConfig
  ENV_CONFIG.each do |key, value|
    const_set key.upcase, value
  end

  class << self
    ENV_CONFIG.each do |key, value|
      define_method(key.to_sym) { value }
    end

    def method_missing(_method_sym, *_arguments, &)
      nil
    end

    def respond_to_missing?(symbol, _include_private)
      ENV_CONFIG.key?(symbol.to_s)
    end
  end
end

class ActsAsTaggableOn::Tag
  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end
end

InlineSvg.configure do |config|
  config.asset_finder = InlineSvg::PropshaftAssetFinder
end

# BetterHtml.configure do |config|
#   config.template_exclusion_filter = proc { |filename| !filename.start_with?(Rails.root.to_s) }
# end
