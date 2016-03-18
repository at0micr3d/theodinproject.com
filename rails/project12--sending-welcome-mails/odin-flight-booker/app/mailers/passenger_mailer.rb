class PassengerMailer < ApplicationMailer
	default from: 'notifications@example.com'
 
  def welcome_email(customer, booking)
    @customer = customer
    @url  = 'http://example.com/login'
    @booking = booking
    mail(to: @customer.email, subject: 'Welcome to My Awesome Site')
  end
end
