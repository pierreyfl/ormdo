json.array!(@devices) do |device|
  json.extract! device, :id, :user_id, :platform, :register, :authentication_token
  json.url device_url(device, format: :json)
end
