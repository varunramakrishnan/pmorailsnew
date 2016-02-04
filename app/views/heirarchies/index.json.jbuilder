json.array!(@heirarchies) do |heirarchy|
  json.extract! heirarchy, :id, :heirarchy_name
  json.url heirarchy_url(heirarchy, format: :json)
end
