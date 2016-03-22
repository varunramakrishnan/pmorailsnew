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

ActiveRecord::Schema.define(version: 20160305104428) do

  create_table "account_resource_mappings", force: :cascade do |t|
    t.integer  "resource_id",       limit: 4
    t.integer  "account_id",        limit: 4
    t.integer  "percentage_loaded", limit: 4
    t.text     "dates",             limit: 65535
    t.string   "status",            limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "account_service_mappings", force: :cascade do |t|
    t.integer  "account_id", limit: 4
    t.integer  "service_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.string   "account_name",           limit: 255
    t.integer  "organisational_unit_id", limit: 4
    t.string   "start_date",             limit: 255
    t.string   "end_date",               limit: 255
    t.integer  "resource_needed",        limit: 4
    t.integer  "resource_allocated",     limit: 4
    t.integer  "resource_id",            limit: 4
    t.string   "status",                 limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "request_type",           limit: 255
    t.string   "date_of_request",        limit: 255
    t.string   "region",                 limit: 255
    t.string   "contact_type",           limit: 255
    t.string   "location",               limit: 255
    t.string   "customer_contact",       limit: 255
    t.text     "other_persons",          limit: 65535
    t.string   "other_sales_email",      limit: 255
    t.string   "sow_status",             limit: 255
    t.string   "account_status",         limit: 255
    t.string   "comments",               limit: 255
    t.string   "delivery_manager",       limit: 255
    t.string   "anticipated_value",      limit: 255
    t.string   "actual_value",           limit: 255
    t.string   "anticipated_start_date", limit: 255
  end

  create_table "heirarchies", force: :cascade do |t|
    t.string   "heirarchy_name", limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "organisational_unit_service_mappings", force: :cascade do |t|
    t.integer  "organisational_unit_id", limit: 4
    t.integer  "service_id",             limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "organisational_units", force: :cascade do |t|
    t.string   "unit_name",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "resource_skill_mappings", force: :cascade do |t|
    t.integer  "resource_id", limit: 4
    t.integer  "skill_id",    limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "resources", force: :cascade do |t|
    t.integer  "employee_id",   limit: 4
    t.string   "employee_name", limit: 255
    t.string   "role",          limit: 255
    t.integer  "heirarchy_id",  limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "services", force: :cascade do |t|
    t.string   "service_name", limit: 255
    t.string   "service_code", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string   "skill_type", limit: 255
    t.string   "skill_name", limit: 255
    t.string   "skill_code", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",   limit: 255
    t.string   "password",   limit: 255
    t.string   "role",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
