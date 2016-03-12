class Flight < ActiveRecord::Base
	belongs_to :from_airport, class_name: "Airport"
  belongs_to :to_airport, class_name: "Airport"
  has_many :bookings

  scope :from_airport, ->(a) { where("from_airport_id = ?", a) }
  scope :to_airport, ->(a) { where("to_airport_id = ?", a) }
  scope :flight_date, ->(d) { where("date(departure_time) in (?)", d) }
end
