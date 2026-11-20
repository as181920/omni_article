json.array! @articles do |article|
  json.extract! article, :id, :uid, :title
end
