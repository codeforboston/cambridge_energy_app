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

ActiveRecord::Schema.define(version: 20160727152525) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.date     "bill_received"
    t.decimal  "amount"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "unit_id"
  end

  add_index "bills", ["unit_id"], name: "index_bills_on_unit_id", using: :btree
  add_index "bills", ["user_id"], name: "index_bills_on_user_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image_url"
  end

  create_table "tips", force: :cascade do |t|
    t.string   "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.integer  "user_building_id"
    t.string   "unit_number"
    t.integer  "sqfootage"
    t.integer  "number_bedrooms"
    t.integer  "number_bathrooms"
    t.integer  "number_rooms"
    t.integer  "number_occupants"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "units", ["user_building_id"], name: "index_units_on_user_building_id", using: :btree

  create_table "uploads", force: :cascade do |t|
    t.string   "filename"
    t.integer  "user_id"
    t.jsonb    "jdoc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_buildings", force: :cascade do |t|
    t.string   "address"
    t.float    "lat"
    t.float    "lon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "prenum"
    t.string   "number"
    t.string   "sufnum"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "plus4"
    t.string   "country"
  end

  create_table "user_tips", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tip_id"
    t.string   "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_tips", ["tip_id"], name: "index_user_tips_on_tip_id", using: :btree
  add_index "user_tips", ["user_id"], name: "index_user_tips_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.integer  "unit_id"
    t.integer  "team_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                               null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.integer  "tipnum"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["provider"], name: "index_users_on_provider", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["team_id"], name: "index_users_on_team_id", using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree
  add_index "users", ["unit_id"], name: "index_users_on_unit_id", using: :btree

  add_foreign_key "bills", "units"
  add_foreign_key "bills", "users"
  add_foreign_key "units", "user_buildings"
  add_foreign_key "user_tips", "tips"
  add_foreign_key "user_tips", "users"
  add_foreign_key "users", "teams"
  add_foreign_key "users", "units"
end
