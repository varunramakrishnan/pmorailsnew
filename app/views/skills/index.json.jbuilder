json.array!(@skills) do |skill|
  json.extract! skill, :id, :skill_type, :skill_name, :skill_code
  json.url skill_url(skill, format: :json)
end
