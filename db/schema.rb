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

ActiveRecord::Schema.define(version: 20151214022746) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.date     "bill_received"
    t.decimal  "amount"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "bills", ["user_id"], name: "index_bills_on_user_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.integer  "user_building_id"
    t.integer  "unit_number"
    t.integer  "sqfootage"
    t.integer  "number_bedrooms"
    t.integer  "number_bathrooms"
    t.integer  "number_rooms"
    t.integer  "number_occupants"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "units", ["user_building_id"], name: "index_units_on_user_building_id", using: :btree

  create_table "user_buildings", force: :cascade do |t|
    t.string   "address"
    t.float    "lat"
    t.float    "lon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street_address"
    t.integer  "phone",          limit: 8
    t.integer  "unit_id"
    t.integer  "team_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "users", ["team_id"], name: "index_users_on_team_id", using: :btree
  add_index "users", ["unit_id"], name: "index_users_on_unit_id", using: :btree

  add_foreign_key "bills", "users"
  add_foreign_key "units", "user_buildings"
  add_foreign_key "users", "teams"
  add_foreign_key "users", "units"
end
