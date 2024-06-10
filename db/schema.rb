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

ActiveRecord::Schema[7.1].define(version: 2024_05_27_061051) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "artist_songs", force: :cascade do |t|
    t.integer "artist_id", null: false
    t.integer "song_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_artist_songs_on_artist_id"
    t.index ["song_id"], name: "index_artist_songs_on_song_id"
  end

  create_table "artists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "songs_count", default: 0
    t.string "first_name_en"
    t.string "first_name_ru"
    t.string "last_name_en"
    t.string "last_name_ru"
    t.string "short_description_en"
    t.string "short_description_ru"
    t.text "description_en"
    t.text "description_ru"
    t.string "slug"
    t.index ["description_en"], name: "index_artists_on_description_en"
    t.index ["description_ru"], name: "index_artists_on_description_ru"
    t.index ["first_name_en"], name: "index_artists_on_first_name_en"
    t.index ["first_name_ru"], name: "index_artists_on_first_name_ru"
    t.index ["last_name_en"], name: "index_artists_on_last_name_en"
    t.index ["last_name_ru"], name: "index_artists_on_last_name_ru"
    t.index ["short_description_en"], name: "index_artists_on_short_description_en"
    t.index ["short_description_ru"], name: "index_artists_on_short_description_ru"
    t.index ["slug"], name: "index_artists_on_slug", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "visible", default: false
    t.integer "records_count", default: 0
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
    t.integer "records_count", default: 0
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

  create_table "preferences", force: :cascade do |t|
    t.string "language"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_preferences_on_user_id"
  end

  create_table "records", force: :cascade do |t|
    t.integer "number", default: 0, null: false
    t.text "tech_info", default: "", null: false
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_records_on_category_id"
  end

  create_table "song_titles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title_en"
    t.string "title_ru"
    t.index ["title_en"], name: "index_song_titles_on_title_en"
    t.index ["title_ru"], name: "index_song_titles_on_title_ru"
  end

  create_table "songs", force: :cascade do |t|
    t.integer "year_of_release"
    t.string "full_title"
    t.integer "song_title_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "variation_en", default: "", null: false
    t.string "variation_ru", default: "", null: false
    t.text "notes_en", default: "", null: false
    t.text "notes_ru", default: "", null: false
    t.text "title_en", default: "", null: false
    t.text "title_ru", default: "", null: false
    t.string "slug"
    t.index ["notes_en"], name: "index_songs_on_notes_en"
    t.index ["notes_ru"], name: "index_songs_on_notes_ru"
    t.index ["slug"], name: "index_songs_on_slug", unique: true
    t.index ["song_title_id"], name: "index_songs_on_song_title_id"
    t.index ["title_en"], name: "index_songs_on_title_en"
    t.index ["title_ru"], name: "index_songs_on_title_ru"
    t.index ["variation_en"], name: "index_songs_on_variation_en"
    t.index ["variation_ru"], name: "index_songs_on_variation_ru"
  end

  create_table "tracks", force: :cascade do |t|
    t.string "number"
    t.integer "song_id"
    t.integer "record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_id"], name: "index_tracks_on_record_id"
    t.index ["song_id"], name: "index_tracks_on_song_id"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "artist_songs", "artists"
  add_foreign_key "artist_songs", "songs"
  add_foreign_key "format_tag_records", "format_tags"
  add_foreign_key "format_tag_records", "records"
  add_foreign_key "preferences", "users"
  add_foreign_key "records", "categories"
  add_foreign_key "songs", "song_titles"
  add_foreign_key "tracks", "records"
  add_foreign_key "tracks", "songs"
end
