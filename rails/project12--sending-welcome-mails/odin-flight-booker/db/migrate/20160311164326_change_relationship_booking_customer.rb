class ChangeRelationshipBookingCustomer < ActiveRecord::Migration
  def change
  	remove_foreign_key :bookings, column: :customer_id
  	add_foreign_key :customers, :bookings
  end
end
