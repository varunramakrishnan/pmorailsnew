json.array!(@organisational_units) do |organisational_unit|
  json.extract! organisational_unit, :id, :unit_name, :unit_code
  json.url organisational_unit_url(organisational_unit, format: :json)
end
