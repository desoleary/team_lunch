json.array!(@orders) do |order|
  json.extract! order, :id, :order_date, :team_id
  json.url order_url(order, format: :json)
end
