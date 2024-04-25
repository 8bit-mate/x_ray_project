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

ActiveRecord::Schema[7.1].define(version: 2024_04_25_141918) do
  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "visible", default: false
    t.string "slug"
    t.string "name_en"
    t.string "name_ru"
    t.string "short_description_en"
    t.string "short_description_ru"
    t.text "description_en"
    t.text "description_ru"
    t.index ["description_en"], name: "index_categories_on_description_en"
    t.index ["description_ru"], name: "index_categories_on_description_ru"
    t.index ["name_en"], name: "index_categories_on_name_en"
    t.index ["name_ru"], name: "index_categories_on_name_ru"
    t.index ["short_description_en"], name: "index_categories_on_short_description_en"
    t.index ["short_description_ru"], name: "index_categories_on_short_description_ru"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "format_tag_records", force: :cascade do |t|
    t.integer "format_tag_id", null: false
    t.integer "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["format_tag_id"], name: "index_format_tag_records_on_format_tag_id"
    t.index ["record_id"], name: "index_format_tag_records_on_record_id"
  end

  create_table "format_tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "visible", default: false
    t.string "name_en"
    t.string "name_ru"
    t.string "short_description_en"
    t.string "short_description_ru"
    t.text "description_en"
    t.text "description_ru"
    t.string "slug"
    t.index ["description_en"], name: "index_format_tags_on_description_en"
    t.index ["description_ru"], name: "index_format_tags_on_description_ru"
    t.index ["name_en"], name: "index_format_tags_on_name_en"
    t.index ["name_ru"], name: "index_format_tags_on_name_ru"
    t.index ["short_description_en"], name: "index_format_tags_on_short_description_en"
    t.index ["short_description_ru"], name: "index_format_tags_on_short_description_ru"
    t.index ["slug"], name: "index_format_tags_on_slug", unique: true
  end

  create_table "records", force: :cascade do |t|
    t.text "tech_info"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_records_on_category_id"
  end

  create_table "songs", force: :cascade do |t|
    t.integer "year_released"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "notes_en"
    t.text "notes_ru"
    t.index ["notes_en"], name: "index_songs_on_notes_en"
    t.index ["notes_ru"], name: "index_songs_on_notes_ru"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "role", default: "user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "format_tag_records", "format_tags"
  add_foreign_key "format_tag_records", "records"
  add_foreign_key "records", "categories"
end
