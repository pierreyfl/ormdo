json.array!(@contacts) do |contact|
  json.extract! contact, :id, :name, :description, :on_call_drugstore, :latitude, :longitude, :deleted_at
  json.url contact_url(contact, format: :json)
end
