# README
Part of theodinproject.com curriculum. [Rails assignment 10](http://www.theodinproject.com/ruby-on-rails/building-advanced-forms)

## DATA MODELS
Booking:
  has_one :flight
  has_many :customers

Airport:
  has_many :arriving_flights, class_name: "Flight", foreign_key: "to_airport_id"
  has_many :departing_flights, class_name: "Flight", foreign_key: "from_airport_id"

Flight:
  belongs_to :from_airport, class_name: "Airport"
  belongs_to :to_airport, class_name: "Airport"
  has_many :bookings

Customer:
  has_one :booking