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

ActiveRecord::Schema.define(version: 2018_04_29_145536) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.string "commenter"
    t.text "body"
    t.bigint "node_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["node_id"], name: "index_comments_on_node_id"
  end

  create_table "datacenters", force: :cascade do |t|
    t.string "name"
    t.string "vendor"
    t.string "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_datacenters_on_slug", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "interfaces", force: :cascade do |t|
    t.bigint "node_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["node_id"], name: "index_interfaces_on_node_id"
  end

  create_table "ip_addrs", force: :cascade do |t|
    t.bigint "mac_id"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mac_id"], name: "index_ip_addrs_on_mac_id"
  end

  create_table "macs", force: :cascade do |t|
    t.bigint "interface_id"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interface_id"], name: "index_macs_on_interface_id"
  end

  create_table "nodes", force: :cascade do |t|
    t.string "name"
    t.string "fqdn"
    t.string "serial"
    t.integer "datacenter_id"
    t.integer "operating_system_id"
    t.integer "status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role_id"
    t.datetime "contract_start_date"
    t.datetime "contract_end_date"
    t.string "slug"
    t.index ["slug"], name: "index_nodes_on_slug", unique: true
  end

  create_table "nodes_roles", id: false, force: :cascade do |t|
    t.bigint "node_id", null: false
    t.bigint "role_id", null: false
    t.index ["node_id", "role_id"], name: "index_nodes_roles_on_node_id_and_role_id", unique: true
    t.index ["role_id", "node_id"], name: "index_nodes_roles_on_role_id_and_node_id", unique: true
  end

  create_table "operating_systems", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_roles_on_slug", unique: true
  end

  create_table "roles_software_apps", id: false, force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "software_app_id", null: false
    t.index ["role_id", "software_app_id"], name: "index_roles_software_apps_on_role_id_and_software_app_id", unique: true
    t.index ["software_app_id", "role_id"], name: "index_roles_software_apps_on_software_app_id_and_role_id", unique: true
  end

  create_table "software_apps", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_statuses_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "nodes"
end
