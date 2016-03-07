class FlightsController < ApplicationController
	def index
		@airport_options = Airport.all.map { |a| [a.code, a.id] }
		@flight_date_options = Flight.all.map { |f| [f.departure_time.to_date, f.id] }
		unless params[:q] == nil
			@flights = Flight.all
		end
	end
end
