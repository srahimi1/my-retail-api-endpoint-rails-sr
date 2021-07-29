# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_08_133549) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_codes", force: :cascade do |t|
    t.string "access_code"
    t.integer "valid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "business_location_payments", force: :cascade do |t|
    t.bigint "business_location_id", null: false
    t.integer "business_location_paid_current"
    t.text "business_location_payment_history"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_location_id"], name: "index_business_location_payments_on_business_location_id"
  end

  create_table "business_locations", force: :cascade do |t|
    t.bigint "business_id", null: false
    t.string "name"
    t.string "street_address"
    t.string "street_address_second_line"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.integer "zip_code_integer"
    t.string "business_assigned_location_id"
    t.string "latitude"
    t.string "longitude"
    t.string "email_address"
    t.string "phone_number"
    t.string "time_zone"
    t.string "unique_id"
    t.datetime "open_time"
    t.datetime "close_time"
    t.datetime "start_waitlist_time"
    t.datetime "stop_waitlist_time"
    t.bigint "number_of_users_in_location"
    t.integer "avg_time_user_in_location"
    t.bigint "max_users_allowed"
    t.bigint "speed_off_waitlist"
    t.text "special_times"
    t.text "entrances_exits"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_id"], name: "index_business_locations_on_business_id"
  end

  create_table "business_locations_waitlists", force: :cascade do |t|
    t.bigint "business_location_id", null: false
    t.bigint "user_id", null: false
    t.bigint "business_id"
    t.bigint "waitlist_position"
    t.datetime "time_on_waitlist"
    t.datetime "time_off_waitlist"
    t.string "on_or_off_waitlist"
    t.string "in_or_out_of_location"
    t.boolean "counted_for_speed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_id"], name: "index_business_locations_waitlists_on_business_id"
    t.index ["business_location_id"], name: "index_business_locations_waitlists_on_business_location_id"
    t.index ["user_id"], name: "index_business_locations_waitlists_on_user_id"
  end

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.text "full_address"
    t.text "street_address"
    t.string "street_address_second_line"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.integer "zip_code_integer"
    t.string "email_address"
    t.string "phone_number"
    t.string "unique_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "confirmation_codes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "confirmation_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_confirmation_codes_on_user_id"
  end

  create_table "stripe_infos", force: :cascade do |t|
    t.bigint "business_location_id", null: false
    t.text "business_location_stripe_customer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_location_id"], name: "index_stripe_infos_on_business_location_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "phone_number_string"
    t.bigint "phone_number_integer"
    t.string "phone_service_provider"
    t.string "gps_location_at_signup"
    t.string "latitude_at_signup"
    t.string "longitude_at_signup"
    t.integer "phone_number_confirmed"
    t.string "latitude"
    t.string "longitude"
    t.text "location_history"
    t.string "unique_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "business_location_payments", "business_locations"
  add_foreign_key "business_locations", "businesses"
  add_foreign_key "business_locations_waitlists", "business_locations"
  add_foreign_key "business_locations_waitlists", "businesses"
  add_foreign_key "business_locations_waitlists", "users"
  add_foreign_key "confirmation_codes", "users"
  add_foreign_key "stripe_infos", "business_locations"
end
