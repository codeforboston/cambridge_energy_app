json.array!(@bill) do |bill|
  json.extract! bill, :id, :bill_received, :amount, :user_id, :usage
  json.url bill_url(bill, format: :json)
end
