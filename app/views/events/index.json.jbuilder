json.array!(@events) do |event|
  json.extract! event, :id, :user_id, :title, :situation_id, :sensitivity, :level
  json.url event_url(event, format: :json)
end
