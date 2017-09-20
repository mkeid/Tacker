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

ActiveRecord::Schema.define(version: 20131127090107) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blocked_users", id: false, force: true do |t|
    t.integer  "blocking_user_id", null: false
    t.integer  "blocked_user_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blocked_users", ["blocking_user_id", "blocked_user_id"], name: "index_blocked_users_on_blocking_user_id_and_blocked_user_id", unique: true, using: :btree

  create_table "friendships", force: true do |t|
    t.integer  "following_user_id",                 null: false
    t.integer  "followed_user_id",                  null: false
    t.string   "followed_user_name",                null: false
    t.boolean  "is_approved",        default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["following_user_id", "followed_user_id"], name: "index_friendships_on_following_user_id_and_followed_user_id", unique: true, using: :btree

  create_table "request_types", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", force: true do |t|
    t.integer  "requesting_user_id", null: false
    t.integer  "requested_user_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "requests", ["requesting_user_id", "requested_user_id"], name: "index_requests_on_requesting_user_id_and_requested_user_id", unique: true, using: :btree

  create_table "trackers", force: true do |t|
    t.integer  "tracking_user_id", null: false
    t.integer  "tracked_user_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "trackers", ["tracking_user_id", "tracked_user_id"], name: "index_trackers_on_tracking_user_id_and_tracked_user_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                        null: false
    t.string   "username",                     null: false
    t.string   "password",                     null: false
    t.string   "salt",                         null: false
    t.string   "reset_token",                  null: false
    t.string   "phone_number",                 null: false
    t.boolean  "is_private",   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["phone_number"], name: "index_users_on_phone_number", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
