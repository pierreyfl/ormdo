json.array!(@link_providers) do |link_provider|
  json.extract! link_provider, :id, :name
  json.url link_provider_url(link_provider, format: :json)
end
