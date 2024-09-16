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

ActiveRecord::Schema[7.1].define(version: 2023_10_22_133724) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "type", null: false
    t.string "identifier", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "properties", default: {}
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "blobs", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "post_id"
    t.bigint "index"
    t.jsonb "content", default: {}
    t.index ["post_id"], name: "index_blobs_on_post_id"
    t.index ["uuid"], name: "index_blobs_on_uuid", unique: true
  end

  create_table "featured_content_posts", force: :cascade do |t|
    t.bigint "featured_content_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["featured_content_id"], name: "index_featured_content_posts_on_featured_content_id"
    t.index ["post_id"], name: "index_featured_content_posts_on_post_id"
  end

  create_table "featured_contents", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "namespaces", force: :cascade do |t|
    t.bigint "site_id"
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_namespaces_on_site_id"
    t.index ["slug"], name: "index_namespaces_on_slug", unique: true
  end

  create_table "post_tags", force: :cascade do |t|
    t.bigint "post_id"
    t.bigint "tag_id"
    t.index ["post_id"], name: "index_post_tags_on_post_id"
    t.index ["tag_id"], name: "index_post_tags_on_tag_id"
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
    t.string "visibility", default: "", null: false
    t.string "thumbnail_blurhash"
    t.index ["author_id"], name: "index_posts_on_author_id"
    t.index ["namespace_id"], name: "index_posts_on_namespace_id"
    t.index ["uuid"], name: "index_posts_on_uuid", unique: true
  end

  create_table "reactions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "post_id"
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_reactions_on_post_id"
    t.index ["user_id"], name: "index_reactions_on_user_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_sites_on_slug", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.bigint "namespace_id"
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["namespace_id"], name: "index_tags_on_namespace_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "display_name", null: false
    t.string "email"
    t.string "profile_image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.string "description"
    t.string "website_url"
    t.index ["display_name"], name: "index_users_on_display_name", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
  end

end
