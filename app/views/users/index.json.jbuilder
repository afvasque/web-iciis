json.array!(@users) do |user|
  json.extract! user, :login, :email, :crypted_password, :salt, :role_id
  json.url user_url(user, format: :json)
end
