class AddSummaryToOmniArticleArticles < ActiveRecord::Migration[8.0]
  def change
    add_column :omni_article_articles, :summary, :text
  end
end
