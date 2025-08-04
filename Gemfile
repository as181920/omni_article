source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

# rubocop:disable Bundler/OrderedGems
gem "debug"
gem "rubocop"
gem "rubocop-erb", require: false
gem "rubocop-minitest", require: false
gem "rubocop-rails-omakase", require: false
gem "rubocop-rake", require: false

gem "guard"
gem "guard-bundler"
gem "guard-minitest"
gem "guard-rubocop"
gem "minitest"
gem "minitest-reporters"
gem "mocha"
gem "pg"
gem "propshaft"
gem "puma"

gem "omni_account", git: "git@gitlab.dd-life.com:shared/omni_account.git", branch: "master"
gem "omni_comment", git: "git@gitlab.dd-life.com:shared/omni_comment.git", branch: "master"
gem "omni_pay", git: "git@gitlab.dd-life.com:shared/omni_pay.git", branch: "master"
gem "omni_region", git: "git@gitlab.dd-life.com:shared/omni_region.git", branch: "master"
gem "omni_role", git: "git@gitlab.dd-life.com:shared/omni_role.git", branch: "master"

gem "wechat_open_platform_proxy", git: "git@gitlab.dd-life.com:weixin.open/wechat_open_platform_proxy.git", branch: "master"
gem "wechat_vendor_platform_proxy", git: "git@gitlab.dd-life.com:weixin.pay/wechat_vendor_platform_proxy.git", branch: "master"

gem "easy_style", git: "git@gitlab.dd-life.com:corp.front_end/easy_style_engine.git", branch: "main"

gem "user_auth", git: "git@gitlab.dd-life.com:shared/user_auth.git", branch: "main"
gem "tenant_auth", git: "git@gitlab.dd-life.com:shared/tenant_auth.git", branch: "main"
gem "organization_auth", git: "git@gitlab.dd-life.com:shared/organization_auth.git", branch: "main"

gem "short_url", git: "git@gitlab.dd-life.com:common_utility/short_url.git", branch: "master"

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webmock"
end
# rubocop:enable Bundler/OrderedGems
