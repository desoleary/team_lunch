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

ActiveRecord::Schema.define(version: 20151220224319) do

  create_table "dietary_restrictions", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "meals", force: :cascade do |t|
    t.integer  "restaurant_id"
    t.integer  "order_id"
    t.integer  "quantity"
    t.integer  "dietary_restriction_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "meals", ["dietary_restriction_id"], name: "index_meals_on_dietary_restriction_id"
  add_index "meals", ["order_id"], name: "index_meals_on_order_id"
  add_index "meals", ["restaurant_id"], name: "index_meals_on_restaurant_id"

  create_table "members", force: :cascade do |t|
    t.string   "first_name",             null: false
    t.string   "last_name"
    t.integer  "team_id"
    t.integer  "dietary_restriction_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "members", ["dietary_restriction_id"], name: "index_members_on_dietary_restriction_id"
  add_index "members", ["team_id"], name: "index_members_on_team_id"

  create_table "orders", force: :cascade do |t|
    t.datetime "order_date"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "orders", ["team_id"], name: "index_orders_on_team_id"

  create_table "restaurant_orders", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "restaurant_id"
    t.integer  "meal_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "restaurant_orders", ["meal_id"], name: "index_restaurant_orders_on_meal_id"
  add_index "restaurant_orders", ["order_id"], name: "index_restaurant_orders_on_order_id"
  add_index "restaurant_orders", ["restaurant_id"], name: "index_restaurant_orders_on_restaurant_id"

  create_table "restaurant_stocks", force: :cascade do |t|
    t.integer  "restaurant_id"
    t.integer  "stock_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "restaurant_stocks", ["restaurant_id"], name: "index_restaurant_stocks_on_restaurant_id"
  add_index "restaurant_stocks", ["stock_id"], name: "index_restaurant_stocks_on_stock_id"

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.integer  "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.integer  "quantity"
    t.integer  "restaurant_id"
    t.integer  "dietary_restriction_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "stocks", ["dietary_restriction_id"], name: "index_stocks_on_dietary_restriction_id"
  add_index "stocks", ["restaurant_id"], name: "index_stocks_on_restaurant_id"

  create_table "teams", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
