json.array!(@comments) do |comment|
  json.extract! comment, :id, :user_id, :body, :event_id, :sensitivity, :level
  json.url comment_url(comment, format: :json)
end
