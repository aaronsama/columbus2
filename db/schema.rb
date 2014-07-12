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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140712134439) do

  create_table "tracks", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "start_location"
    t.string   "end_location"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "track_file_name"
    t.string   "track_content_type"
    t.integer  "track_file_size"
    t.datetime "track_updated_at"
    t.datetime "start_date"
    t.integer  "duration"
    t.float    "distance"
    t.integer  "min_speed"
    t.integer  "max_speed"
    t.integer  "min_height"
    t.integer  "max_height"
    t.binary   "points"
  end

end
