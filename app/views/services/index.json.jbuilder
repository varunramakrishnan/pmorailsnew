json.array!(@services) do |service|
  json.extract! service, :id, :service_name, :service_code, :mapping_format
  json.url service_url(service, format: :json)
end
