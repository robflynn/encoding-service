# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_21_222017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assets", force: :cascade do |t|
    t.integer "task_id"
    t.string "task_type"
    t.integer "store_id"
    t.string "file_path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["store_id"], name: "index_assets_on_store_id"
    t.index ["task_id", "task_type"], name: "index_assets_on_task_id_and_task_type"
  end

  create_table "encoding_profiles", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "encoding_tasks", force: :cascade do |t|
    t.string "name"
    t.string "status", default: "created"
    t.bigint "output_store_id", null: false
    t.string "output_path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "encoding_profile_id", null: false
    t.integer "completed_renditions"
    t.index ["encoding_profile_id"], name: "index_encoding_tasks_on_encoding_profile_id"
    t.index ["output_store_id"], name: "index_encoding_tasks_on_output_store_id"
    t.index ["status"], name: "index_encoding_tasks_on_status"
  end

  create_table "renditions", force: :cascade do |t|
    t.bigint "encoding_profile_id", null: false
    t.string "name"
    t.string "description"
    t.integer "width"
    t.integer "height"
    t.decimal "fps", precision: 5, scale: 2
    t.integer "video_bitrate"
    t.integer "audio_bitrate"
    t.string "container", limit: 16, default: "mp4"
    t.string "video_codec", limit: 8, default: "h264"
    t.string "profile", limit: 16, default: "main"
    t.string "audio_codec", limit: 8, default: "aac"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["encoding_profile_id"], name: "index_renditions_on_encoding_profile_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.text "secured_configuration", default: "{}"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["type"], name: "index_stores_on_type"
  end

  add_foreign_key "encoding_tasks", "encoding_profiles"
  add_foreign_key "encoding_tasks", "stores", column: "output_store_id"
  add_foreign_key "renditions", "encoding_profiles"
end
