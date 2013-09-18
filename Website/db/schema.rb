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

ActiveRecord::Schema.define(:version => 0) do

  create_table "Tweet", :primary_key => "id_tweet", :force => true do |t|
    t.string   "text",          :limit => 300
    t.string   "img_url",       :limit => 300
    t.datetime "date_tweet",                   :null => false
    t.float    "location_lat"
    t.float    "location_long"
    t.integer  "id_user",       :limit => 8,   :null => false
  end

  add_index "Tweet", ["id_user"], :name => "FK_id_user"

  create_table "User", :primary_key => "id_user", :force => true do |t|
    t.string "username",      :limit => 30,  :null => false
    t.string "name",          :limit => 50,  :null => false
    t.string "profile_image", :limit => 200
  end

end
