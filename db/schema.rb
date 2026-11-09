# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_11_09_151945) do
  create_table "divisions", force: :cascade do |t|
    t.string "name"
    t.string "conference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fans", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "player_follows", force: :cascade do |t|
    t.integer "fan_id", null: false
    t.integer "player_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fan_id"], name: "index_player_follows_on_fan_id"
    t.index ["player_id"], name: "index_player_follows_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.integer "nhl_id"
    t.string "first_name"
    t.string "last_name"
    t.integer "sweater_number"
    t.string "position_code"
    t.integer "height_inches"
    t.integer "weight_pounds"
    t.date "birth_date"
    t.string "birth_country"
    t.string "headshot_url"
    t.integer "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "team_follows", force: :cascade do |t|
    t.integer "fan_id", null: false
    t.integer "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fan_id"], name: "index_team_follows_on_fan_id"
    t.index ["team_id"], name: "index_team_follows_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "abbrev"
    t.integer "wins"
    t.integer "losses"
    t.integer "ot_losses"
    t.integer "points"
    t.string "logo_url"
    t.integer "division_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["division_id"], name: "index_teams_on_division_id"
  end

  add_foreign_key "player_follows", "fans"
  add_foreign_key "player_follows", "players"
  add_foreign_key "players", "teams"
  add_foreign_key "team_follows", "fans"
  add_foreign_key "team_follows", "teams"
  add_foreign_key "teams", "divisions"
end
