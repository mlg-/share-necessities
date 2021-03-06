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

ActiveRecord::Schema.define(version: 20150723172106) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dibs", force: :cascade do |t|
    t.integer  "user_id",                         null: false
    t.integer  "quantity",                        null: false
    t.integer  "item_id",                         null: false
    t.string   "status",     default: "Promised", null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "imports", force: :cascade do |t|
    t.integer "user_id",         null: false
    t.integer "organization_id", null: false
    t.string  "url"
    t.text    "page_html"
  end

  create_table "items", force: :cascade do |t|
    t.string  "name",            null: false
    t.integer "quantity",        null: false
    t.string  "url"
    t.text    "description"
    t.integer "organization_id", null: false
    t.string  "thumbnail_url"
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name",                  null: false
    t.string   "address",               null: false
    t.string   "city",                  null: false
    t.string   "state",                 null: false
    t.string   "zip",                   null: false
    t.text     "description"
    t.string   "phone"
    t.string   "email",                 null: false
    t.string   "url"
    t.string   "display_photo"
    t.text     "delivery_instructions"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "organizers", force: :cascade do |t|
    t.integer "user_id",         null: false
    t.integer "organization_id", null: false
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "pg_search_documents", ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                      default: "",    null: false
    t.string   "encrypted_password",         default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",              default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "first_name",                                 null: false
    t.string   "last_name",                                  null: false
    t.boolean  "admin",                      default: false, null: false
    t.string   "profile_photo"
    t.text     "bio"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",          default: 0
    t.integer  "invited_by_organization_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
