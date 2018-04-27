json.array!(@users) do |user|
  json.extract! user, :id, :name, :deleted_at
  json.url user_url(user, format: :json)
end
