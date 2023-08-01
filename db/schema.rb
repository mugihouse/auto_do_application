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

ActiveRecord::Schema[7.0].define(version: 2023_07_31_121641) do
  create_table "day_of_weeks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profile_day_of_weeks", force: :cascade do |t|
    t.integer "profile_id", null: false
    t.integer "day_of_week_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_of_week_id"], name: "index_profile_day_of_weeks_on_day_of_week_id"
    t.index ["profile_id"], name: "index_profile_day_of_weeks_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.time "dinner_time", null: false
    t.time "bedtime", null: false
    t.integer "holiday_of_week", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.text "body"
    t.integer "time_required", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "line_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["line_id"], name: "index_users_on_line_id"
  end

  add_foreign_key "profile_day_of_weeks", "day_of_weeks"
  add_foreign_key "profile_day_of_weeks", "profiles"
  add_foreign_key "profiles", "users"
  add_foreign_key "tasks", "users"
end
