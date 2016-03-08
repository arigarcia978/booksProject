json.array!(@shelves) do |shelf|
  json.extract! shelf, :id, :user_id, :name
  json.url shelf_url(shelf, format: :json)
end
