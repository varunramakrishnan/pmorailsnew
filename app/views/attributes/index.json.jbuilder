json.array!(@attributes) do |attribute|
  json.extract! attribute, :id, :attribute_type, :attribute_key, :attribute_value, :active_status
  json.url attribute_url(attribute, format: :json)
end
