json.array!(@services) do |service|
  json.extract! service, :id, :service_name, :service_code
  json.url service_url(service, format: :json)
end
