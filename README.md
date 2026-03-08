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
