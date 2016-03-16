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

ActiveRecord::Schema.define(version: 20160315211029) do

  create_table "anaylitics", force: :cascade do |t|
    t.decimal  "lat"
    t.decimal  "long"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facilities", force: :cascade do |t|
    t.string   "name"
    t.string   "welcomes"
    t.string   "services"
    t.decimal  "lat"
    t.decimal  "long"
    t.string   "address"
    t.string   "phone"
    t.string   "website"
    t.text     "description"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "startsmon_at"
    t.time     "endsmon_at"
    t.time     "startstues_at"
    t.time     "endstues_at"
    t.time     "startswed_at"
    t.time     "endswed_at"
    t.time     "startsthurs_at"
    t.time     "endsthurs_at"
    t.time     "startsfri_at"
    t.time     "endsfri_at"
    t.time     "startssat_at"
    t.time     "endssat_at"
    t.time     "startssun_at"
    t.time     "endssun_at"
    t.string   "suitability"
    t.boolean  "r_pets",               default: false
    t.boolean  "r_id",                 default: false
    t.boolean  "r_cart",               default: false
    t.boolean  "r_phone",              default: false
    t.boolean  "r_wifi",               default: false
    t.time     "startsmon_at2"
    t.time     "endsmon_at2"
    t.time     "startstues_at2"
    t.time     "endstues_at2"
    t.time     "startswed_at2"
    t.time     "endswed_at2"
    t.time     "startsthurs_at2"
    t.time     "endsthurs_at2"
    t.time     "startsfri_at2"
    t.time     "endsfri_at2"
    t.time     "startssat_at2"
    t.time     "endssat_at2"
    t.time     "startssun_at2"
    t.time     "endssun_at2"
    t.boolean  "open_all_day_mon"
    t.boolean  "open_all_day_tues"
    t.boolean  "open_all_day_wed"
    t.boolean  "open_all_day_thurs"
    t.boolean  "open_all_day_fri"
    t.boolean  "open_all_day_sat"
    t.boolean  "open_all_day_sun"
    t.boolean  "closed_all_day_mon"
    t.boolean  "closed_all_day_tues"
    t.boolean  "closed_all_day_wed"
    t.boolean  "closed_all_day_thurs"
    t.boolean  "closed_all_day_fri"
    t.boolean  "closed_all_day_sat"
    t.boolean  "closed_all_day_sun"
    t.boolean  "second_time_mon",      default: false
    t.boolean  "second_time_tues",     default: false
    t.boolean  "second_time_wed",      default: false
    t.boolean  "second_time_thurs",    default: false
    t.boolean  "second_time_fri",      default: false
    t.boolean  "second_time_sat",      default: false
    t.boolean  "second_time_sun",      default: false
    t.integer  "user_id"
  end

  add_index "facilities", ["user_id"], name: "index_facilities_on_user_id"

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id"

  create_table "statuses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "fid"
    t.string   "changetype"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
    t.boolean  "activation_email_sent", default: false
  end

end
