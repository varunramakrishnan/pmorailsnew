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

ActiveRecord::Schema.define(version: 20161110120006) do

  create_table "account_resource_mappings", force: :cascade do |t|
    t.integer  "resource_id",       limit: 4
    t.integer  "account_id",        limit: 4
    t.decimal  "percentage_loaded",               precision: 10, scale: 2
    t.text     "dates",             limit: 65535
    t.string   "status",            limit: 255
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.integer  "service_id",        limit: 4
    t.integer  "project_id",        limit: 4
  end

  create_table "account_service_mappings", force: :cascade do |t|
    t.integer  "account_id",             limit: 4
    t.integer  "service_id",             limit: 4
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.integer  "no_of_people_needed",    limit: 4
    t.integer  "no_of_people_allocated", limit: 4
    t.string   "request_date",           limit: 255
    t.string   "start_date",             limit: 255
    t.string   "end_date",               limit: 255
    t.string   "contract_type",          limit: 255
    t.string   "project_status",         limit: 255
    t.string   "sow_status",             limit: 255
    t.string   "sow_signed_date",        limit: 255
    t.string   "currency",               limit: 255
    t.decimal  "anticipated_value",                    precision: 20, scale: 2
    t.decimal  "actual_value",                         precision: 20, scale: 2
    t.decimal  "anticipated_usd_value",                precision: 20, scale: 2
    t.decimal  "actual_usd_value",                     precision: 20, scale: 2
    t.string   "health",                 limit: 255
    t.text     "comments",               limit: 65535
  end

  create_table "accounts", force: :cascade do |t|
    t.string   "account_name",           limit: 255
    t.integer  "organisational_unit_id", limit: 4
    t.integer  "resource_id",            limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "region",                 limit: 255
    t.string   "location",               limit: 255
    t.string   "comments",               limit: 255
    t.string   "account_code",           limit: 255
    t.string   "project_status",         limit: 255
    t.string   "account_lob",            limit: 255
    t.string   "account_contact",        limit: 255
    t.string   "csm_contact",            limit: 255
    t.string   "sales_contact",          limit: 255
    t.string   "pm_contact",             limit: 255
    t.string   "overall_health",         limit: 255
  end

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
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
    t.string   "unit_code",  limit: 255
  end

  create_table "projects", force: :cascade do |t|
    t.string   "project_name",      limit: 255
    t.string   "project_code",      limit: 255
    t.integer  "account_id",        limit: 4
    t.integer  "service_id",        limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "parent_id",         limit: 4
    t.integer  "version",           limit: 4
    t.string   "start_date",        limit: 255
    t.string   "end_date",          limit: 255
    t.integer  "estimated_efforts", limit: 4
    t.string   "createdBy",         limit: 255
    t.string   "modifiedBy",        limit: 255
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
    t.string   "pm_contact",    limit: 255
    t.integer  "manager_id",    limit: 4
  end

  create_table "roles", force: :cascade do |t|
    t.string   "role_name",    limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "heirarchy_id", limit: 4
    t.string   "role_code",    limit: 255
  end

  create_table "services", force: :cascade do |t|
    t.string   "service_name",   limit: 255
    t.string   "service_code",   limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "mapping_format", limit: 255
  end

  create_table "skills", force: :cascade do |t|
    t.string   "skill_type", limit: 255
    t.string   "skill_name", limit: 255
    t.string   "skill_code", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "time_tracks", force: :cascade do |t|
    t.integer  "resource_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.string   "project_id",  limit: 255
    t.string   "date",        limit: 255
    t.string   "status",      limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "hrs_logged",  limit: 4
    t.string   "week_id",     limit: 255
    t.integer  "account_id",  limit: 4
    t.integer  "service_id",  limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",    limit: 255
    t.string   "password",    limit: 255
    t.string   "role",        limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "employee_id", limit: 255
  end

end
