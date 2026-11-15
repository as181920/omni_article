# OmniArticle
通用文章功能(Rails engine)

## Usage

- `GET /omni_article/api-docs`
- `GET /omni_article/api-docs/openapi.json`
- Article UI-specific rendering preferences should live in `article.custom_settings`, not dedicated columns.
- Current user-side article payload includes `list_display_style` derived from `OmniArticle::Article::UiSettings`.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'omni_article', git: "git@github.com:as181920/omni_article.git", branch: "master"
```

And then execute:
```bash
$ bundle
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Development and CI

本地与 GitLab CI 统一运行 `bin/ci`，包含实时依赖漏洞审计、Brakeman、RuboCop、测试库重建、Zeitwerk 和完整测试。数据库操作固定为 test 环境；使用 Ruby 4.0.9／Rails 8.1.4.1 验证。

管理员沿用 TenantAuth／OrganizationAuth 的既有身份和权限；浏览器 cookie／Basic 写请求需 CSRF，显式有效凭据仍按原服务认证，失败不回退到 cookie。微信分享配置通过 JSON 序列化及脚本上下文转义，保留文章标题及链接的原值。
