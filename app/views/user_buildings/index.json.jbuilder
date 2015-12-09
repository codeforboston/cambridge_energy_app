json.array!(@user_buildings) do |user_building|
  json.extract! user_building, :id, :address, :lat, :lon
  json.url user_building_url(user_building, format: :json)
end
