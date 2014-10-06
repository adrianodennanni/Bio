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

ActiveRecord::Schema.define(version: 20140925165632) do

  create_table "tweets", force: true do |t|
    t.text     "text"
    t.text     "img_url"
    t.datetime "date_tweet"
    t.float    "latitude",     limit: 24
    t.float    "longitude",    limit: 24
    t.text     "full_address"
    t.string   "city"
    t.string   "country"
    t.string   "hashtag"
    t.text     "urls"
    t.integer  "user_id"
    t.integer  "up_votes"
    t.integer  "down_votes"
    t.integer  "reports"
  end

  create_table "users", force: true do |t|
    t.string  "username"
    t.string  "name"
    t.text    "profile_image"
    t.text    "profile_bio"
    t.integer "num_followers"
    t.integer "num_following"
    t.integer "num_tweets"
    t.string  "profile_created_at"
    t.string  "location"
    t.text    "website"
    t.integer "up_votes"
    t.integer "down_votes"
    t.integer "reports"
  end

  create_table "webusers", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "webusers", ["email"], name: "index_webusers_on_email", unique: true, using: :btree
  add_index "webusers", ["reset_password_token"], name: "index_webusers_on_reset_password_token", unique: true, using: :btree

end
