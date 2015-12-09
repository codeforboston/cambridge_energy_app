json.array!(@units) do |unit|
  json.extract! unit, :id, :user_building_id, :unit_number, :sqfootage, :number_bedrooms, :number_bathrooms, :number_rooms, :number_occupants
  json.url unit_url(unit, format: :json)
end
