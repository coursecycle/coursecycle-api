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

ActiveRecord::Schema.define(version: 20150316232641) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.string "api_key"
  end

  create_table "courses", force: :cascade do |t|
    t.string  "subject"
    t.string  "code"
    t.string  "title"
    t.string  "description"
    t.integer "ecid"
  end

  create_table "instructors", force: :cascade do |t|
    t.string "name"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "sunet"
    t.string "role"
  end

  create_table "instructors_sections", id: false, force: :cascade do |t|
    t.integer "instructor_id"
    t.integer "section_id"
  end

  add_index "instructors_sections", ["instructor_id"], name: "index_instructors_sections_on_instructor_id", using: :btree
  add_index "instructors_sections", ["section_id"], name: "index_instructors_sections_on_section_id", using: :btree

  create_table "sections", force: :cascade do |t|
    t.integer  "ecid"
    t.string   "season"
    t.string   "year"
    t.datetime "start"
    t.datetime "end"
    t.string   "location"
    t.string   "component"
  end

end
