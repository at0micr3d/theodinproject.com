class FlightsController < ApplicationController
	def index
		@airport_options = Airport.all.map { |a| [a.code, a.id] }
		p @flight_date_options = Flight.all.map { |f| [f.departure_time.to_date, f.id] }
		

		unless params[:departure_date] == nil
			selected_date = @flight_date_options.select { |arr|  arr[1] == params[:departure_date].to_i }[0][0].to_s # returns the string of the selected date from the :date params.
			@flights = Flight.from_airport(params[:from_airport_id]).to_airport(params[:to_airport_id]).flight_date(selected_date)
		end
	end
end
#