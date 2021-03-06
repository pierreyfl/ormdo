json.array!(@contact_types) do |contact_type|
  json.extract! contact_type, :id, :name, :parent_contact_type_id, :deleted_at
  json.url contact_type_url(contact_type, format: :json)
end
