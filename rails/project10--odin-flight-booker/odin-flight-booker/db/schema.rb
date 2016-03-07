# encoding: UTF-8

ActiveRecord::Schema.define(version: 20160306142717) do

  create_table "airports", force: :cascade do |t|
    t.string   "code"
    t.string   "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "airports", ["code"], name: "index_airports_on_code"

  create_table "bookings", force: :cascade do |t|
    t.date     "date"
    t.integer  "flight_id"
    t.integer  "customer_id"
    t.decimal  "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "bookings", ["customer_id"], name: "index_bookings_on_customer_id"
  add_index "bookings", ["flight_id"], name: "index_bookings_on_flight_id"

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.integer  "age"
    t.integer  "passport_nr"
    t.integer  "street"
    t.string   "city"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "customers", ["name"], name: "index_customers_on_name"

  create_table "flights", force: :cascade do |t|
    t.integer  "number"
    t.integer  "from_airport_id"
    t.integer  "to_airport_id"
    t.datetime "departure_time"
    t.integer  "flight_duration"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "flights", ["from_airport_id"], name: "index_flights_on_from_airport_id"
  add_index "flights", ["to_airport_id"], name: "index_flights_on_to_airport_id"

end
