json.array!(@organizations) do |organization|
  json.extract! organization, :id, :name, :country
  json.url organization_url(organization, format: :json)
end
