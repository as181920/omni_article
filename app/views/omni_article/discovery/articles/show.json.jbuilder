json.extract! @article, :uid, :updated_at
json.title @title
json.summary @summary
json.canonical_url @canonical_url
json.content_html @content.html
