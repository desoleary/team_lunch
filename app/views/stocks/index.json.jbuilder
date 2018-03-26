json.array!(@stocks) do |stock|
  json.extract! stock, :id, :quantity, :restaurant_id, :dietary_restriction_id
  json.url stock_url(stock, format: :json)
end
