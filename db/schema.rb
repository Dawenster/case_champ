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

ActiveRecord::Schema.define(version: 20170529214045) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "competitions", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_files", force: :cascade do |t|
    t.string   "original_filename"
    t.string   "public_id"
    t.string   "resource_type"
    t.string   "secure_url"
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "sponsor"
    t.text     "description"
    t.string   "city"
    t.string   "state_and_country"
    t.integer  "min_team_size"
    t.integer  "max_team_size"
    t.string   "num_kellogg_teams_allowed"
    t.text     "logistics"
    t.text     "application"
    t.string   "application_url"
    t.string   "contact_name"
    t.string   "position_and_organization"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "competition_id"
    t.string   "image_url"
    t.boolean  "published",                 default: false
  end

  create_table "interests", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "milestones", force: :cascade do |t|
    t.datetime "deadline_at"
    t.string   "description"
    t.integer  "event_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "prizes", force: :cascade do |t|
    t.integer  "rank"
    t.integer  "amount_in_dollars"
    t.string   "description"
    t.integer  "event_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email"
    t.boolean  "admin"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "program"
    t.string   "majors"
    t.string   "image_url"
    t.integer  "class_year"
    t.string   "latest_token"
  end

end
