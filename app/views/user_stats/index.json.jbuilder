json.array!(@user_stats) do |user_stat|
  json.extract! user_stat, :id, :user_email, :points, :category
  json.url user_stat_url(user_stat, format: :json)
end
