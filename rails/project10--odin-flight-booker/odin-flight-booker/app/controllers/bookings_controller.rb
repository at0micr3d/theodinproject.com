class BookingsController < ApplicationController
	def new
		@flight = Flight.find(params[:flight_id])
		@booking = Booking.new
		nr_passengers = params[:nr_passengers].to_i
		nr_passengers.times do
			@booking.customers << Customer.new
		end
	end

	def show
		@booking = Booking.find(params[:id])
		@passengers = @booking.customers
		@flight = @booking.flight
	end

	def create
		@booking = Booking.new(booking_params)
		@booking.date = DateTime.now
		@booking.price = @booking.customers.count * 500

		if @booking.save
			flash[:succes] = "You have booked the flight"
			redirect_to @booking
		else
			flash[:error] = "Could not book your flight"
			render 'flights#index'
		end
	end

	private 

	def booking_params
		params.require(:booking).permit(:flight_id, customers_attributes: [ :name, :age, :passport_nr, :street, :city ])
	end

end