# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_04_18_204046) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "postgis"

  create_table "caber_relations", force: :cascade do |t|
    t.string "subject_type"
    t.string "subject_id"
    t.string "permission"
    t.string "object_type", null: false
    t.string "object_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["object_type", "object_id"], name: "index_caber_relations_on_object"
    t.index ["subject_id", "subject_type", "object_id", "object_type"], name: "idx_on_subject_id_subject_type_object_id_object_typ_a279b094be", unique: true
    t.index ["subject_type", "subject_id"], name: "index_caber_relations_on_subject"
  end

  create_table "companies", id: :string, force: :cascade do |t|
    t.string "organization_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_companies_on_organization_id"
  end

  create_table "company_employees", id: :string, force: :cascade do |t|
    t.string "company_id", null: false
    t.string "employee_id", null: false
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_employees_on_company_id"
    t.index ["employee_id"], name: "index_company_employees_on_employee_id"
  end

  create_table "customers", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "company_id", null: false
    t.index ["company_id"], name: "index_customers_on_company_id"
  end

  create_table "employees", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizations", id: :string, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rides", id: :string, force: :cascade do |t|
    t.string "customer_id", null: false
    t.string "company_id", null: false
    t.string "driver_id"
    t.json "origin_address", null: false
    t.geometry "origin_coordinate", limit: {srid: 0, type: "st_point"}, null: false
    t.json "destination_address", null: false
    t.geometry "destination_coordinate", limit: {srid: 0, type: "st_point"}, null: false
    t.integer "seats", default: 1, null: false
    t.json "estimates", null: false
    t.datetime "requested_at", precision: nil
    t.datetime "canceled_at", precision: nil
    t.datetime "picked_up_at", precision: nil
    t.datetime "completed_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_rides_on_company_id"
    t.index ["customer_id"], name: "index_rides_on_customer_id"
    t.index ["driver_id"], name: "index_rides_on_driver_id"
  end

  create_table "service_areas", id: :string, force: :cascade do |t|
    t.string "name"
    t.geometry "boundary", limit: {srid: 0, type: "geometry"}
    t.integer "status"
    t.string "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_service_areas_on_company_id"
  end

  create_table "sessions", id: :string, force: :cascade do |t|
    t.string "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", id: :string, force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "authenticateable_type", null: false
    t.string "authenticateable_id", null: false
    t.string "organization_id", null: false
    t.index ["authenticateable_type", "authenticateable_id"], name: "index_users_on_authenticateable"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
  end

  add_foreign_key "companies", "organizations"
  add_foreign_key "company_employees", "companies"
  add_foreign_key "company_employees", "employees"
  add_foreign_key "customers", "companies"
  add_foreign_key "rides", "companies"
  add_foreign_key "rides", "customers"
  add_foreign_key "rides", "employees", column: "driver_id"
  add_foreign_key "service_areas", "companies"
  add_foreign_key "sessions", "users"
  add_foreign_key "users", "organizations"
end
