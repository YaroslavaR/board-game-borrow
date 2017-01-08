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

ActiveRecord::Schema.define(version: 20170108152847) do

  create_table "games", force: :cascade do |t|
    t.string   "title"
    t.integer  "min_players"
    t.integer  "max_players"
    t.integer  "min_player_age"
    t.integer  "playing_time"
    t.float    "complexity"
    t.string   "location"
    t.string   "link"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.float    "rating"
    t.integer  "expansion_for"
  end

  create_table "rentals", force: :cascade do |t|
    t.string   "name"
    t.date     "start_time"
    t.date     "end_time"
    t.integer  "game_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "user_id"
    t.integer  "is_optional", default: 0
    t.integer  "is_vetoed"
    t.index ["game_id"], name: "index_rentals_on_game_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.integer  "is_admin",               default: 0,  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "name"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
