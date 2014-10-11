json.array!(@subcategories) do |subcategory|
  json.extract! subcategory, :id, :name, :postid
  json.url subcategory_url(subcategory, format: :json)
end
