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

ActiveRecord::Schema.define(version: 20131011015821) do

  create_table "projects", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "methodology"
    t.string   "publication"
    t.string   "summary"
  end

  create_table "projects_researchers", id: false, force: true do |t|
    t.integer "project_id"
    t.integer "researcher_id"
  end

  create_table "projects_study_sites", id: false, force: true do |t|
    t.integer "project_id"
    t.integer "study_site_id"
  end

  create_table "researchers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "study_sites", force: true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "gmaps"
  end

end
