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

ActiveRecord::Schema.define(version: 20140924145548) do

  create_table "tweets", force: true do |t|
    t.text     "text"
    t.string   "img_url"
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

end
