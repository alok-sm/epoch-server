json.array!(@articles) do |article|
  json.extract! article, :id, :title, :category, :photo, :code, :time,:subcategory
  json.url article_url(article, format: :json)
end
