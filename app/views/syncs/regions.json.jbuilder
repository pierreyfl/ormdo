json.array!(@regions) do |region|
  json.extract! region, :id, :state, :name, :deleted_at, :created_at, :updated_at, :sync_uuid
end