json.array!(@time_tracks) do |time_track|
  json.extract! time_track, :id, :resource_id, :user_id, :project_id, :date, :status,:comments,
  json.url time_track_url(time_track, format: :json)
end
