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

ActiveRecord::Schema.define(version: 20140823221933) do

  create_table "Tweet", primary_key: "id_tweet", force: true do |t|
    t.string   "text",         limit: 300
    t.string   "img_url",      limit: 300
    t.datetime "date_tweet",               null: false
    t.float    "latitude",     limit: 24
    t.float    "longitude",    limit: 24
    t.string   "full_address", limit: 300
    t.string   "city",         limit: 50
    t.string   "country",      limit: 30
    t.string   "hashtag",      limit: 15
    t.string   "urls",         limit: 200
    t.integer  "id_user",      limit: 8,   null: false
    t.integer  "up_votes"
    t.integer  "down_votes"
    t.integer  "reports"
  end

  add_index "Tweet", ["id_user"], name: "FK_id_user", using: :btree

  create_table "User", primary_key: "id_user", force: true do |t|
    t.string  "username",           limit: 30,  null: false
    t.string  "name",               limit: 50,  null: false
    t.string  "profile_image",      limit: 200
    t.string  "profile_bio",        limit: 300
    t.integer "num_followers"
    t.integer "num_following"
    t.integer "num_tweets"
    t.string  "profile_created_at", limit: 100
    t.string  "location",           limit: 200
    t.string  "website",            limit: 500
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
