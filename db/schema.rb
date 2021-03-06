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

ActiveRecord::Schema.define(version: 20151124020109) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string  "image_url"
    t.string  "street_number"
    t.string  "street_name"
    t.string  "street_type"
    t.string  "apt_number"
    t.string  "city"
    t.string  "state"
    t.string  "zipcode"
    t.integer "price"
    t.string  "bedrooms"
    t.string  "lat"
    t.string  "long"
    t.string  "walkscore"
    t.string  "built"
    t.string  "listing_url"
    t.string  "neighborhood"
    t.string  "crime_rate"
  end

  create_table "favorites", force: :cascade do |t|
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "search_results", force: :cascade do |t|
    t.integer "search_id"
    t.integer "address_id"
    t.string  "pindex"
    t.string  "pindex_price"
    t.string  "pindex_walkscore"
    t.string  "pindex_commutescore"
    t.string  "pindex_crimerate"
    t.string  "price_weight"
    t.string  "commute_weight"
    t.string  "walkscore_weight"
    t.string  "crime_weight"
  end

  create_table "searches", force: :cascade do |t|
  end

  create_table "user_favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "favorite_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
