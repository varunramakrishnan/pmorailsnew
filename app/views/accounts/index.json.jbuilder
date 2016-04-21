json.array!(@accounts) do |account|
  json.extract! account, :id, :account_name, :account_code,:organisational_unit_id, :start_date, :end_date, :resource_needed, :resource_allocated, :resource_id, :status, :request_type, :date_of_request, :region, :contract_type, :location, :customer_contact, :other_persons, :other_sales_email, :sow_status, :account_status, :comments,  :delivery_manager, :anticipated_value, :actual_value,  :anticipated_start_date
  json.url account_url(account, format: :json)
end
