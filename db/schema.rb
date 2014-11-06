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

ActiveRecord::Schema.define(version: 20141103235616) do

  create_table "ingredients", force: true do |t|
    t.string   "name"
    t.integer  "quantity"
    t.string   "measurement"
    t.integer  "recipe_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "orders", force: true do |t|
    t.string   "leftovers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes", force: true do |t|
    t.integer  "big_oven_recipe_id"
    t.string   "title"
    t.string   "description"
    t.string   "web_url"
    t.string   "image_url"
    t.integer  "star_rating"
    t.integer  "review_count"
    t.text     "instructions"
    t.integer  "yield_number"
    t.integer  "order_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

end
