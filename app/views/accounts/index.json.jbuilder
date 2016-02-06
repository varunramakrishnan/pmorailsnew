json.array!(@accounts) do |account|
  json.extract! account, :id, :account_name, :organisational_unit_id, :start_date, :end_date, :resource_needed, :resource_allocated, :resource_id, :status
  json.url account_url(account, format: :json)
end
