json.array!(@bills) do |bill|
  json.extract! bill, :id, :bill_received, :amount, :usage, :user_id
  json.url bill_url(bill, format: :json)
end
