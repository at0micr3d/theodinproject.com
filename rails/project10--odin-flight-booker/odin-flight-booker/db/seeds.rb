
# create some airports
a1 = Airport.create(code: "SFO", city: "San Fransisco")
a2 = Airport.create(code: "AMS", city: "Amsterdam")
a3 = Airport.create(code: "EIN", city: "Eindhoven")
a4 = Airport.create(code: "CDG", city: "Paris")


# create some flights between airports
f1 = Flight.create(number: 1, from_airport_id: 1, to_airport_id: 2, :departure_time => (DateTime.now + 3.days), :flight_duration => (3600 * 10))
f2 = Flight.create(number: 2, from_airport_id: 2, to_airport_id: 1, :departure_time => (DateTime.now + 2.days), :flight_duration => (3600 * 10))
f3 = Flight.create(number: 3, from_airport_id: 2, to_airport_id: 3, :departure_time => (DateTime.now + 10.days), :flight_duration => (3600 * 2))
f4 = Flight.create(number: 4, from_airport_id: 3, to_airport_id: 4, :departure_time => (DateTime.now + 10.days), :flight_duration => (3600 * 2))