class BookingsController < ApplicationController
	def new
		@flight = Flight.find(params[:flight_id])
		@booking = Booking.new
		params[:nr_passengers].to_i.times do
			@booking.customers << Customer.new
		end
	end

	def create
		
	end

	private 


end
