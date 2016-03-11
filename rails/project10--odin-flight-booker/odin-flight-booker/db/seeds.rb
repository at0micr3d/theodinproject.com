
# create some airports
a1 = Airport.create(code: "SFO", city: "San Fransisco")
a2 = Airport.create(code: "AMS", city: "Amsterdam")
a3 = Airport.create(code: "EIN", city: "Eindhoven")
a4 = Airport.create(code: "CDG", city: "Paris")


# create some flights between airports
(1..20).each do |i|
	Flight.create(number: 1, from_airport_id: 1, to_airport_id: 2, :departure_time => (DateTime.now + i.days), :flight_duration => (3600 * 10))
end

Flight.create(number: 1, from_airport_id: 1, to_airport_id: 2, :departure_time => (DateTime.now + 1.days), :flight_duration => (3600 * 10)) # 1 additional flight to test radio buttons

(1..20).each do |i|
	Flight.create(number: 2, from_airport_id: 2, to_airport_id: 1, :departure_time => (DateTime.now + i.days), :flight_duration => (3600 * 10))
end

(1..20).each do |i|
	Flight.create(number: 3, from_airport_id: 2, to_airport_id: 3, :departure_time => (DateTime.now + i.days + 10.days), :flight_duration => (3600 * 2))
end

(1..20).each do |i|
	Flight.create(number: 4, from_airport_id: 3, to_airport_id: 4, :departure_time => (DateTime.now + i.days + 10.days), :flight_duration => (3600 * 2))
end