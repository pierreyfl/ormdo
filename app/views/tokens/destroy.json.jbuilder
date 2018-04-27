json.user do |user|
  user.extract! @user, :id, :name, :email, :role
end
