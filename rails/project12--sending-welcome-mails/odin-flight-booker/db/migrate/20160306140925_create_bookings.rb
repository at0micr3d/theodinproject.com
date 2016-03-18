class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.date :date
      t.references :flight, :index => true
      t.references :customer, :index => true
      t.decimal :price

      t.timestamps null: false
    end
  end
end
