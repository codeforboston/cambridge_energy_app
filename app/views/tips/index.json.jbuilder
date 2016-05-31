json.array!(@tips) do |tip|
  json.extract! tip, :id, :text
  json.url tip_url(tip, format: :json)
end
