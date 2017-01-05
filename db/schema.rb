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

ActiveRecord::Schema.define(version: 20170103222835) do

  create_table "games", force: :cascade do |t|
    t.string   "title"
    t.integer  "min_players"
    t.integer  "max_players"
    t.integer  "min_player_age"
    t.integer  "max_player_age"
    t.integer  "playing_time"
    t.float    "complexity"
    t.string   "location"
    t.string   "link"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "rentals", force: :cascade do |t|
    t.string   "name"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_rentals_on_game_id"
  end

end
