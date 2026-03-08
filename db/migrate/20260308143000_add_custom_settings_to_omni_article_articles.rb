class AddCustomSettingsToOmniArticleArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :omni_article_articles, :custom_settings, :jsonb
  end
end
