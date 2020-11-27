class AddUidToOmniArticleArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :omni_article_articles, :uid, :string
    add_index :omni_article_articles, :uid, unique: true
  end
end
