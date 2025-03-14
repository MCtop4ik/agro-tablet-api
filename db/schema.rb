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

ActiveRecord::Schema[7.1].define(version: 2025_03_08_193455) do
  create_table "authenticated_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_id"
    t.string "token"
    t.integer "expire_time"
  end

  create_table "hay_farms", force: :cascade do |t|
    t.integer "record_pk", null: false
    t.string "channel_kw", null: false
    t.integer "sequence", null: false
    t.boolean "active_yn", default: true
    t.string "farm_name"
    t.integer "add_user_pk"
    t.string "add_user_name"
    t.datetime "add_date_time"
    t.string "add_ip"
    t.string "add_browser"
    t.integer "upd_user_fk"
    t.string "upd_user_name"
    t.datetime "upd_date_time"
    t.string "upd_ip"
    t.string "upd_browser"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hay_fields", force: :cascade do |t|
    t.integer "record_pk", null: false
    t.string "channel_kw", null: false
    t.integer "sequence", null: false
    t.boolean "active_yn", default: true
    t.integer "parent_farm_fk"
    t.string "field_id"
    t.float "field_acres"
    t.float "latitude"
    t.float "longitude"
    t.string "field_pdf"
    t.integer "add_user_pk"
    t.string "add_user_name"
    t.datetime "add_date_time"
    t.string "add_ip"
    t.string "add_browser"
    t.integer "upd_user_fk"
    t.string "upd_user_name"
    t.datetime "upd_date_time"
    t.string "upd_ip"
    t.string "upd_browser"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hay_lookups", force: :cascade do |t|
    t.integer "record_pk", null: false
    t.string "channel_kw", null: false
    t.integer "sequence", null: false
    t.boolean "active_yn", default: true
    t.string "category_kw"
    t.string "keyword"
    t.string "keyword_ck"
    t.text "description"
    t.integer "numeric_value"
    t.integer "add_user_pk"
    t.string "add_user_name"
    t.datetime "add_date_time"
    t.string "add_ip"
    t.string "add_browser"
    t.integer "upd_user_fk"
    t.string "upd_user_name"
    t.datetime "upd_date_time"
    t.string "upd_ip"
    t.string "upd_browser"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hay_production_transactions", primary_key: "record_pk", force: :cascade do |t|
    t.string "channel_kw"
    t.integer "sequence"
    t.boolean "active_yn", default: true
    t.integer "field_fk"
    t.integer "user_fk"
    t.datetime "transaction_date"
    t.string "hay_type_kw"
    t.string "hay_cut_kw"
    t.integer "start_hours_kw"
    t.integer "start_minutes_kw"
    t.integer "end_hours_kw"
    t.integer "end_minutes_kw"
    t.decimal "total_time_hours", precision: 5, scale: 2
    t.decimal "tons_baled", precision: 10, scale: 2
    t.integer "bales_baled"
    t.decimal "average_moisture_percent", precision: 5, scale: 2
    t.decimal "acres", precision: 10, scale: 2
    t.decimal "tons_per_acre", precision: 10, scale: 2
    t.decimal "bales_per_acre", precision: 10, scale: 2
    t.decimal "tons_per_hour", precision: 10, scale: 2
    t.decimal "bales_per_hour", precision: 10, scale: 2
    t.integer "add_user_pk"
    t.string "add_user_name"
    t.datetime "add_date_time"
    t.string "add_ip"
    t.string "add_browser"
    t.integer "upd_user_fk"
    t.string "upd_user_name"
    t.datetime "upd_date_time"
    t.string "upd_ip"
    t.string "upd_browser"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hay_users", force: :cascade do |t|
    t.integer "record_pk", null: false
    t.string "channel_kw", null: false
    t.integer "sequence", null: false
    t.boolean "active_yn", default: true
    t.string "first_name"
    t.string "last_name"
    t.string "full_name"
    t.string "email", null: false
    t.string "password_digest", null: false
    t.integer "add_user_pk"
    t.string "add_user_name"
    t.datetime "add_date_time"
    t.string "add_ip"
    t.string "add_browser"
    t.integer "upd_user_fk"
    t.string "upd_user_name"
    t.datetime "upd_date_time"
    t.string "upd_ip"
    t.string "upd_browser"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "old_new_record_pks", force: :cascade do |t|
    t.string "old_record_pk"
    t.string "new_record_pk"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "unaccepted_transactions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "data"
    t.string "status"
  end

end
