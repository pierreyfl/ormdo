json.array!(@regions) do |region|
  json.extract! region, :id, :state, :name, :ddd, :deleted_at
  json.url region_url(region, format: :json)
end
