json.array!(@tips) do |tip|
  json.extract! tip, :id, :text, :worked, :failed
  json.url tip_url(tip, format: :json)
end
