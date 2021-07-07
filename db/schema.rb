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

ActiveRecord::Schema.define(version: 2021_07_05_111701) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bmis", force: :cascade do |t|
    t.integer "height", null: false
    t.float "weight", null: false
    t.float "status"
    t.date "record_on", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bmis_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "foods", force: :cascade do |t|
    t.string "name", null: false
    t.integer "protein", null: false
    t.integer "quantity", null: false
    t.string "unit", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_foods_on_user_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_friendships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_friendships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_friendships_on_follower_id"
  end

  create_table "nutrition_record_lines", force: :cascade do |t|
    t.integer "ate"
    t.bigint "nutrition_record_id"
    t.bigint "food_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_id"], name: "index_nutrition_record_lines_on_food_id"
    t.index ["nutrition_record_id"], name: "index_nutrition_record_lines_on_nutrition_record_id"
  end

  create_table "nutrition_records", force: :cascade do |t|
    t.date "start_time", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_nutrition_records_on_user_id"
  end

  create_table "replies", force: :cascade do |t|
    t.text "comment", null: false
    t.integer "replier_id", null: false
    t.bigint "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_replies_on_contact_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "name", null: false
    t.string "profile_image"
    t.string "profile_comment"
    t.integer "protein_target"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bmis", "users"
  add_foreign_key "contacts", "users"
  add_foreign_key "foods", "users"
  add_foreign_key "nutrition_record_lines", "foods"
  add_foreign_key "nutrition_record_lines", "nutrition_records"
  add_foreign_key "nutrition_records", "users"
  add_foreign_key "replies", "contacts"
end
