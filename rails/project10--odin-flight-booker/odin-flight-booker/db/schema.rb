# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160312095701) do

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
    t.decimal  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bookings", ["flight_id"], name: "index_bookings_on_flight_id"

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.integer  "age"
    t.integer  "passport_nr"
    t.string   "street"
    t.string   "city"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "booking_id"
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
