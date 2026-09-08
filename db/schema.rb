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

ActiveRecord::Schema[8.1].define(version: 2026_09_08_125232) do
  create_table "bookings", force: :cascade do |t|
    t.time "booking_time"
    t.datetime "created_at", null: false
    t.integer "lesson_id", null: false
    t.string "status"
    t.integer "student_id", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id", "student_id"], name: "index_bookings_on_lesson_id_and_student_id", unique: true
    t.index ["lesson_id"], name: "index_bookings_on_lesson_id"
    t.index ["student_id"], name: "index_bookings_on_student_id"
  end

  create_table "cancellation_policies", force: :cascade do |t|
    t.integer "cancellation_time"
    t.datetime "created_at", null: false
    t.decimal "refund_percentage"
    t.integer "studio_id", null: false
    t.datetime "updated_at", null: false
    t.index ["studio_id"], name: "index_cancellation_policies_on_studio_id"
  end

  create_table "instructors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.integer "studio_id", null: false
    t.datetime "updated_at", null: false
    t.index ["studio_id"], name: "index_instructors_on_studio_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.time "cancelled_at"
    t.integer "capacity"
    t.string "code"
    t.datetime "created_at", null: false
    t.integer "instructor_id"
    t.string "name"
    t.string "slug"
    t.time "start_time"
    t.string "status"
    t.integer "studio_id", null: false
    t.datetime "updated_at", null: false
    t.index ["instructor_id"], name: "index_lessons_on_instructor_id"
    t.index ["studio_id", "code"], name: "index_lessons_on_studio_id_and_code", unique: true
    t.index ["studio_id", "slug"], name: "index_lessons_on_studio_id_and_slug", unique: true
    t.index ["studio_id"], name: "index_lessons_on_studio_id"
  end

  create_table "students", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.integer "studio_id", null: false
    t.datetime "updated_at", null: false
    t.index ["studio_id"], name: "index_students_on_studio_id"
  end

  create_table "studios", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "slug"
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_studios_on_slug", unique: true
  end

  add_foreign_key "bookings", "lessons"
  add_foreign_key "bookings", "students"
  add_foreign_key "cancellation_policies", "studios"
  add_foreign_key "instructors", "studios"
  add_foreign_key "lessons", "instructors"
  add_foreign_key "lessons", "studios"
  add_foreign_key "students", "studios"
end
