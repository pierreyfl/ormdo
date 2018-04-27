json.array!(@phones) do |phone|
  json.extract! phone, :id, :area, :number, :priority, :description, :deleted_at
  json.url phone_url(phone, format: :json)
end
