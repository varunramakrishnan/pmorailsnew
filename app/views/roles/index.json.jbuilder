json.array!(@roles) do |role|
  json.extract! role, :id, :role_name, :heirarchy_id
  json.url role_url(role, format: :json)
end
