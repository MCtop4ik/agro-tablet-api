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

ActiveRecord::Schema[7.1].define(version: 2024_06_02_224416) do
  create_table "authenticated_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_id"
    t.string "token"
    t.integer "expire_time"
  end

  create_table "old_new_record_pk", force: :cascade do |t|
    t.string "old_record_pk"
    t.string "new_record_pk"
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
