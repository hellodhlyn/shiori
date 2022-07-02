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

ActiveRecord::Schema[7.0].define(version: 2022_03_10_140902) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "namespaces", force: :cascade do |t|
    t.bigint "site_id"
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_namespaces_on_site_id"
    t.index ["slug"], name: "index_namespaces_on_slug", unique: true
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "namespace_id"
    t.string "uuid", null: false
    t.string "title", null: false
    t.string "slug", null: false
    t.text "description"
    t.string "thumbnail_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "author_id"
    t.index ["author_id"], name: "index_posts_on_author_id"
    t.index ["namespace_id"], name: "index_posts_on_namespace_id"
    t.index ["uuid"], name: "index_posts_on_uuid", unique: true
  end

  create_table "sites", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_sites_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "display_name", null: false
    t.string "email", null: false
    t.string "profile_image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["display_name"], name: "index_users_on_display_name", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["user_id"], name: "index_users_on_user_id", unique: true
  end

end
