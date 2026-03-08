ui_settings = OmniArticle::Article::UiSettings.new(@article.custom_settings)

json.extract! @article, :id, :uid, :title, :summary, :content, :created_at, :updated_at
json.list_display_style ui_settings.list_display_style
json.url article_path(@article.uid)
json.icon_url(@article.icon.attached? ? cdn_url(@article.icon) : nil)
json.tag_list @article.tag_list
