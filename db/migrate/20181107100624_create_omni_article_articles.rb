class CreateOmniArticleArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :omni_article_articles do |t|
      t.references :owner, polymorphic: true, index: {name: :index_omni_article_articles_on_woner}
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
