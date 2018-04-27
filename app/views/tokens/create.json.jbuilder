json.user do |user|
  user.extract! @user, :id, :name, :email, :role
end

json.device_id @device.id
json.token @device.authentication_token