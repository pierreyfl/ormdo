json.array!(@external_links) do |external_link|
  json.extract! external_link, :id, :name, :link, :deleted_at
  json.url external_link_url(external_link, format: :json)
end
