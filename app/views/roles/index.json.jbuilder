json.array!(@roles) do |role|
  json.extract! role, :id, :role_name,:role_code, :heirarchy_id
  json.url role_url(role, format: :json)
end
