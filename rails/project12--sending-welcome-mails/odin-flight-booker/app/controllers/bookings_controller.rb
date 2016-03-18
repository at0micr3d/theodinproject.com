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
		nr_customers = params[:booking][:customers_attributes].count
		@booking.price = nr_customers * 500
		@customer = @booking.customers.first
		if @booking.save
			flash[:succes] = "You have booked the flight!"
			PassengerMailer.welcome_email(@customer, @booking).deliver_later
			redirect_to @booking
		else
			flash[:error] = "Could not book your flight!"
			render 'flights#index'
		end
	end

	private 

	def booking_params
		params.require(:booking).permit(:flight_id, customers_attributes: [ :name, :age, :passport_nr, :street, :city, :email ])
	end

end