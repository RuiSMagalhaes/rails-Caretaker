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

ActiveRecord::Schema.define(version: 2019_03_05_092726) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "diseases", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "start_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.datetime "end_time"
    t.boolean "recurring"
    t.integer "minutes"
    t.integer "hours"
    t.integer "days"
    t.integer "weeks"
    t.integer "months"
    t.integer "start_id"
    t.boolean "notify_before"
    t.boolean "notify_done"
    t.boolean "notify_missed"
    t.bigint "user_id"
    t.bigint "event_type_id"
    t.index ["event_type_id"], name: "index_events_on_event_type_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.boolean "dismissed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_notifications_on_event_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "relations", force: :cascade do |t|
    t.integer "caretaker_id", null: false
    t.integer "patient_id", null: false
    t.boolean "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["caretaker_id", "patient_id"], name: "index_relations_on_caretaker_id_and_patient_id", unique: true
    t.index ["caretaker_id"], name: "index_relations_on_caretaker_id"
    t.index ["patient_id"], name: "index_relations_on_patient_id"
  end

  create_table "user_diseases", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "disease_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["disease_id"], name: "index_user_diseases_on_disease_id"
    t.index ["user_id"], name: "index_user_diseases_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "simple_view"
    t.string "photo"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "events", "event_types"
  add_foreign_key "events", "users"
  add_foreign_key "notifications", "events"
  add_foreign_key "notifications", "users"
  add_foreign_key "user_diseases", "diseases"
  add_foreign_key "user_diseases", "users"
end
