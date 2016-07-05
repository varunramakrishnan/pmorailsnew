json.array!(@projects) do |project|
  json.extract! project, :id, :project_name, :project_code, :account_id, :service_id,:start_date,:end_date
  json.url project_url(project, format: :json)
end
