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

ActiveRecord::Schema.define(version: 20170520220851) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas_rescuers", id: false, force: :cascade do |t|
    t.integer "area_id",    null: false
    t.integer "rescuer_id", null: false
  end

  create_table "feed_items", force: :cascade do |t|
    t.integer  "rescue_action_id"
    t.text     "text"
    t.string   "author"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["rescue_action_id"], name: "index_feed_items_on_rescue_action_id", using: :btree
  end

  create_table "invites", force: :cascade do |t|
    t.integer  "rescue_action_id"
    t.integer  "rescuer_id"
    t.integer  "status",           default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["rescue_action_id"], name: "index_invites_on_rescue_action_id", using: :btree
  end

  create_table "rescue_action_area_points", force: :cascade do |t|
    t.integer  "rescue_action_area_id"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "index"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["rescue_action_area_id"], name: "index_rescue_action_area_points_on_rescue_action_area_id", using: :btree
  end

  create_table "rescue_action_areas", force: :cascade do |t|
    t.integer  "rescue_action_id"
    t.string   "name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.text     "points"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "zoom_level"
    t.index ["rescue_action_id"], name: "index_rescue_action_areas_on_rescue_action_id", using: :btree
  end

  create_table "rescue_action_areas_rescuers", id: false, force: :cascade do |t|
    t.integer "rescue_action_area_id", null: false
    t.integer "rescuer_id",            null: false
  end

  create_table "rescue_actions", force: :cascade do |t|
    t.integer  "lead_id"
    t.boolean  "is_search"
    t.integer  "kind"
    t.float    "start_position_latitude"
    t.float    "start_position_longitude"
    t.text     "description"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "rescue_member_locations", force: :cascade do |t|
    t.integer  "rescue_member_id"
    t.datetime "location_on"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["rescue_member_id"], name: "index_rescue_member_locations_on_rescue_member_id", using: :btree
  end

  create_table "rescue_members", force: :cascade do |t|
    t.integer  "rescuer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rescuer_id"], name: "index_rescue_members_on_rescuer_id", using: :btree
  end

  create_table "rescuers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.text     "availability"
    t.string   "phone_number"
    t.string   "address_home"
    t.float    "home_latitude"
    t.float    "home_longitude"
    t.string   "address_work"
    t.float    "work_latitude"
    t.float    "work_longitude"
    t.integer  "level"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "rescuers_specialties", force: :cascade do |t|
    t.integer "rescuer_id"
    t.integer "specialty_id"
    t.index ["rescuer_id"], name: "index_rescuers_specialties_on_rescuer_id", using: :btree
    t.index ["specialty_id"], name: "index_rescuers_specialties_on_specialty_id", using: :btree
  end

  create_table "specialties", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "rescuer_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["rescuer_id"], name: "index_users_on_rescuer_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "feed_items", "rescue_actions"
  add_foreign_key "invites", "rescue_actions"
  add_foreign_key "rescue_action_area_points", "rescue_action_areas"
  add_foreign_key "rescue_action_areas", "rescue_actions"
  add_foreign_key "rescue_member_locations", "rescue_members"
  add_foreign_key "rescue_members", "rescuers"
  add_foreign_key "rescuers_specialties", "rescuers"
  add_foreign_key "rescuers_specialties", "specialties"
end
