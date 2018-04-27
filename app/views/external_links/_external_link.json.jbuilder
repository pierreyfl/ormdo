if (external_link.present?)
  json.external_link do
    json.extract! external_link, :id, :name, :link_type, :link, :deleted_at, :created_at, :updated_at
  end
end
