json.array!(@projects) do |project|
  json.extract! project, :id, :project_name, :project_code, :account_id, :account_name,  :service_id,:service_name,:start_date,:end_date,:estimated_efforts
  json.url project_url(project, format: :json)
end
