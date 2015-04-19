json.array!(@entries) do |entry|
  json.extract! entry, :id, :owner_id, :blog_id, :title, :body, :created_at, :updated_at
  json.url entry_url(entry, format: :json)
end
