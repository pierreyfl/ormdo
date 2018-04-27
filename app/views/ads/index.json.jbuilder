json.array!(@ads) do |ad|
  json.extract! ad, :id, :view_type, :visit_type, :title, :description, :position, :start_date, :end_date, :deleted_at

  json.region do
    json.extract! region, :id, :name, :state, :sync_uuid, :updated_at, :created_at
  end
end
