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

ActiveRecord::Schema.define(version: 20160307013222) do

  create_table "books", force: :cascade do |t|
    t.string   "isbn"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "reviews_quantity", default: 0
    t.integer  "rates_total",      default: 0
  end

  create_table "books_shelves", force: :cascade do |t|
    t.integer "book_id",  null: false
    t.integer "shelf_id", null: false
  end

  add_index "books_shelves", ["book_id", "shelf_id"], name: "index_books_shelves_on_book_id_and_shelf_id", unique: true

  create_table "reviewings", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "user_id"
    t.decimal  "rate",       default: 1.0
    t.string   "review"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "reviewings", ["book_id"], name: "index_reviewings_on_book_id"
  add_index "reviewings", ["user_id"], name: "index_reviewings_on_user_id"

  create_table "shelves", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "shelves", ["user_id"], name: "index_shelves_on_user_id"

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
