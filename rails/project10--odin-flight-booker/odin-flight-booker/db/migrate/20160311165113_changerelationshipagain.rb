class Changerelationshipagain < ActiveRecord::Migration
  def change
  	remove_index :bookings, :customer_id
  	remove_column :bookings, :customer_id
  	add_column :customers, :booking_id, :integer
  end
end
