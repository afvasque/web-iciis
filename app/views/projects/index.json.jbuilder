json.array!(@projects) do |project|
  json.extract! project, :title, :latitude, :longitude
  json.url project_url(project, format: :json)
end
