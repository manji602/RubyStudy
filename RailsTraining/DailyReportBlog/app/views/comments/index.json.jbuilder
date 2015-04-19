json.array!(@comments) do |comment|
  json.extract! comment, :id, :owner_id, :entry_id, :body, :created_at
  json.url comment_url(comment, format: :json)
end
