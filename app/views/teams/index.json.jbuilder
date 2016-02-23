json.array!(@teams) do |team|
  json.extract! team, :id, :name, :image_url
  json.url team_url(team, format: :json)
end
