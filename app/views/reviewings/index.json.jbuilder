json.array!(@reviewings) do |reviewing|
  json.extract! reviewing, :id, :book_id, :user_id, :rate, :review
  json.url reviewing_url(reviewing, format: :json)
end
