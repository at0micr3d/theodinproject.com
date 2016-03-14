json.array!(@scooters) do |scooter|
  json.extract! scooter, :id
  json.url scooter_url(scooter, format: :json)
end
