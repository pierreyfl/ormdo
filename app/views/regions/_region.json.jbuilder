if (region.present?)
  json.region do
    json.extract! region, :id, :state, :name, :ddd, :deleted_at, :created_at, :updated_at
  end
end
