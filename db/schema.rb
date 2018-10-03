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

ActiveRecord::Schema.define(version: 20181003023911) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "epic_snapshots", force: :cascade do |t|
    t.integer  "epics_id"
    t.integer  "completed_storypoints"
    t.integer  "total_storypoints"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["epics_id"], name: "index_epic_snapshots_on_epics_id", using: :btree
  end

  create_table "epics", force: :cascade do |t|
    t.string   "jira_id"
    t.string   "name"
    t.integer  "highest_storypoint_count"
    t.datetime "origin_date"
    t.integer  "unestimated_tickets"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "is_active",                default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "password_digest"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
