json.array!(@resources) do |resource|
  json.extract! resource, :id, :employee_id, :employee_name, :role, :heirarchy_id,:manager_id
  json.url resource_url(resource, format: :json)
end
