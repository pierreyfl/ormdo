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

ActiveRecord::Schema.define(version: 20180427195831) do

  create_table "ads", force: :cascade do |t|
    t.integer  "view_type",   limit: 4
    t.integer  "visit_type",  limit: 4
    t.string   "title",       limit: 255
    t.string   "description", limit: 255
    t.integer  "position",    limit: 4
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_id",  limit: 4
    t.integer  "region_id",   limit: 4
    t.string   "advertiser",  limit: 255
    t.string   "keyword",     limit: 255
    t.string   "sync_uuid",   limit: 255
  end

  add_index "ads", ["region_id"], name: "index_ads_on_region_id", using: :btree

  create_table "ads_external_links", id: false, force: :cascade do |t|
    t.integer "ad_id",            limit: 4, null: false
    t.integer "external_link_id", limit: 4, null: false
  end

  add_index "ads_external_links", ["ad_id", "external_link_id"], name: "index_ads_external_links_on_ad_id_and_external_link_id", using: :btree
  add_index "ads_external_links", ["external_link_id", "ad_id"], name: "index_ads_external_links_on_external_link_id_and_ad_id", using: :btree

  create_table "ads_photos", id: false, force: :cascade do |t|
    t.integer "ad_id",    limit: 4, null: false
    t.integer "photo_id", limit: 4, null: false
  end

  add_index "ads_photos", ["ad_id", "photo_id"], name: "index_ads_photos_on_ad_id_and_photo_id", using: :btree
  add_index "ads_photos", ["photo_id", "ad_id"], name: "index_ads_photos_on_photo_id_and_ad_id", using: :btree

  create_table "ads_regions", id: false, force: :cascade do |t|
    t.integer "ad_id",     limit: 4, null: false
    t.integer "region_id", limit: 4, null: false
  end

  add_index "ads_regions", ["ad_id", "region_id"], name: "index_ads_regions_on_ad_id_and_region_id", using: :btree
  add_index "ads_regions", ["region_id", "ad_id"], name: "index_ads_regions_on_region_id_and_ad_id", using: :btree

  create_table "contact_types", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_contact_type_id", limit: 4
    t.string   "uploader_file_name",     limit: 255
    t.string   "uploader_content_type",  limit: 255
    t.integer  "uploader_file_size",     limit: 4
    t.datetime "uploader_updated_at"
  end

  add_index "contact_types", ["parent_contact_type_id"], name: "index_contact_types_on_parent_contact_type_id", using: :btree

  create_table "contact_types_contacts", id: false, force: :cascade do |t|
    t.integer "contact_id",      limit: 4, null: false
    t.integer "contact_type_id", limit: 4, null: false
  end

  add_index "contact_types_contacts", ["contact_id", "contact_type_id"], name: "index_contact_types_contacts_on_contact_id_and_contact_type_id", using: :btree
  add_index "contact_types_contacts", ["contact_type_id", "contact_id"], name: "index_contact_types_contacts_on_contact_type_id_and_contact_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.integer  "region_id",            limit: 4
    t.string   "name",                 limit: 255
    t.text     "description",          limit: 65535
    t.decimal  "latitude",                           precision: 9, scale: 6
    t.decimal  "longitude",                          precision: 9, scale: 6
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_type_id",      limit: 4
    t.integer  "sponsorship_id",       limit: 4
    t.text     "address",              limit: 65535
    t.boolean  "helpful",                                                    default: false
    t.string   "sync_uuid",            limit: 255
    t.boolean  "open_24",                                                    default: false
    t.text     "search_field",         limit: 65535
    t.text     "address_for_geocoder", limit: 65535
    t.boolean  "on_call_drugstore",                                          default: false
    t.boolean  "subscriber",                                                 default: false
  end

  add_index "contacts", ["contact_type_id"], name: "index_contacts_on_contact_type_id", using: :btree

  create_table "contacts_external_links", id: false, force: :cascade do |t|
    t.integer "contact_id",       limit: 4, null: false
    t.integer "external_link_id", limit: 4, null: false
  end

  add_index "contacts_external_links", ["contact_id", "external_link_id"], name: "index_contacts_external_links_on_contact_id_and_external_link_id", using: :btree
  add_index "contacts_external_links", ["external_link_id", "contact_id"], name: "index_contacts_external_links_on_external_link_id_and_contact_id", using: :btree

  create_table "contacts_photos", id: false, force: :cascade do |t|
    t.integer "contact_id", limit: 4, null: false
    t.integer "photo_id",   limit: 4, null: false
  end

  add_index "contacts_photos", ["contact_id", "photo_id"], name: "index_contacts_photos_on_contact_id_and_photo_id", using: :btree
  add_index "contacts_photos", ["photo_id", "contact_id"], name: "index_contacts_photos_on_photo_id_and_contact_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "devices", force: :cascade do |t|
    t.integer  "user_id",              limit: 4
    t.string   "platform",             limit: 255
    t.string   "register",             limit: 255
    t.string   "authentication_token", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "devices", ["authentication_token"], name: "index_devices_on_authentication_token", unique: true, using: :btree
  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "external_links", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "link",             limit: 255
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "link_provider_id", limit: 4
    t.integer  "link_type",        limit: 4
  end

  add_index "external_links", ["link_provider_id"], name: "index_external_links_on_link_provider_id", using: :btree

  create_table "link_providers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phones", force: :cascade do |t|
    t.string   "area",        limit: 255
    t.string   "number",      limit: 255
    t.float    "priority",    limit: 24
    t.string   "description", limit: 255
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_id",  limit: 4
    t.integer  "carrier",     limit: 4
  end

  add_index "phones", ["contact_id"], name: "index_phones_on_contact_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "main",                          default: false
  end

  create_table "regions", force: :cascade do |t|
    t.string   "state",                 limit: 255
    t.string   "name",                  limit: 255
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",               limit: 4
    t.string   "sync_uuid",             limit: 255
    t.string   "ddd",                   limit: 255
    t.string   "uploader_file_name",    limit: 255
    t.string   "uploader_content_type", limit: 255
    t.integer  "uploader_file_size",    limit: 4
    t.datetime "uploader_updated_at"
  end

  add_index "regions", ["user_id"], name: "index_regions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.integer  "role",                   limit: 4
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
