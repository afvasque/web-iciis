json.array!(@study_sites) do |study_site|
  json.extract! study_site, :start_date, :end_date, :data_collection_method, :name, :description, :latitude, :longitude, :location
  json.url study_site_url(study_site, format: :json)
end
