json.array!(@researchers) do |researcher|
  json.extract! researcher, :name, :email, :website
  json.url researcher_url(researcher, format: :json)
end
