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

ActiveRecord::Schema[7.1].define(version: 2024_10_20_201217) do
  create_table "directors", force: :cascade do |t|
    t.string "name"
    t.string "nacionality"
    t.date "birthdate"
    t.integer "favorite_genre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["favorite_genre_id"], name: "index_directors_on_favorite_genre_id"
  end

  create_table "genre_descriptions", force: :cascade do |t|
    t.string "genre_name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "year"
    t.text "synopsis"
    t.string "country"
    t.integer "duration"
    t.boolean "isSketch"
    t.integer "director_id", null: false
    t.integer "genre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cover_url"
    t.string "original_title"
    t.index ["director_id"], name: "index_movies_on_director_id"
    t.index ["genre_id"], name: "index_movies_on_genre_id"
  end

  add_foreign_key "directors", "genres", column: "favorite_genre_id"
  add_foreign_key "movies", "directors"
  add_foreign_key "movies", "genres"
end
