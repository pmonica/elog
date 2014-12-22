json.array!(@situations) do |situation|
  json.extract! situation, :id, :name, :description
  json.url situation_url(situation, format: :json)
end
