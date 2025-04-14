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

ActiveRecord::Schema[8.0].define(version: 2025_04_14_024949) do
  create_table "access_logs", charset: "latin1", force: :cascade do |t|
    t.bigint "employee_id"
    t.datetime "timestamp"
    t.string "status"
    t.string "device_id"
    t.string "image_file_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_access_logs_on_employee_id"
  end

  create_table "employees", charset: "latin1", force: :cascade do |t|
    t.string "full_name"
    t.string "position"
    t.string "department"
    t.text "face_encoding"
    t.string "image_file_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fire_alerts", charset: "latin1", force: :cascade do |t|
    t.datetime "timestamp"
    t.string "location"
    t.string "camera_id"
    t.string "image_file_path"
    t.float "confidence_score"
    t.string "status"
    t.boolean "is_sent_to_web", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "access_logs", "employees"
end
