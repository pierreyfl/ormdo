json.external_links do
  json.array!(external_links) do |external_link|
    json.extract! external_link, :id, :name, :link_type, :link, :deleted_at, :created_at, :updated_at
  end
end