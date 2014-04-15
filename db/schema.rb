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

ActiveRecord::Schema.define(version: 20140415224912) do

  create_table "activities", force: true do |t|
    t.string   "name"
    t.date     "day"
    t.time     "time"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "length"
  end

  create_table "exercises", force: true do |t|
    t.string   "name"
    t.date     "day"
    t.time     "time"
    t.integer  "length"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "calories"
  end

  add_index "exercises", ["user_id"], name: "index_exercises_on_user_id", unique: true

  create_table "foods", force: true do |t|
    t.string   "name"
    t.integer  "calories"
    t.date     "day"
    t.time     "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "foods", ["user_id"], name: "index_foods_on_user_id", unique: true

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "auth_token"
    t.string   "gender"
    t.date     "birthdate"
    t.integer  "height"
    t.integer  "weight"
    t.string   "status"
    t.string   "fname"
    t.string   "lname"
    t.boolean  "admin"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
