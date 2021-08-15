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

ActiveRecord::Schema.define(version: 2021_07_11_140102) do

  create_table "book_names", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "testament", null: false
    t.string "japanese", null: false
    t.string "english", null: false
  end

  create_table "bookmarks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "folder_id"
    t.integer "position", null: false
    t.string "title", null: false
    t.string "action_name", null: false
    t.string "controller_name", null: false
    t.text "params_value", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["folder_id"], name: "index_bookmarks_on_folder_id"
  end

  create_table "books", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "version", null: false
    t.bigint "book_name_id"
    t.integer "chapter", null: false
    t.integer "verse", null: false
    t.text "word", null: false
    t.index ["book_name_id"], name: "index_books_on_book_name_id"
  end

  create_table "folders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "home_id"
    t.string "title", null: false
    t.boolean "sticky", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["home_id"], name: "index_folders_on_home_id"
  end

  create_table "homes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "slides", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "home_id"
    t.string "title", null: false
    t.text "body", null: false
    t.string "author", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["discarded_at"], name: "index_slides_on_discarded_at"
    t.index ["home_id"], name: "index_slides_on_home_id"
  end

  create_table "song_edits", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "song_id"
    t.text "words", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["song_id"], name: "index_song_edits_on_song_id"
  end

  create_table "songs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "home_id"
    t.string "code", null: false
    t.string "title", null: false
    t.text "words", null: false
    t.text "words_for_search", null: false
    t.string "cright", null: false
    t.timestamp "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["discarded_at"], name: "index_songs_on_discarded_at"
    t.index ["home_id"], name: "index_songs_on_home_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "home_id"
    t.string "name"
    t.string "password_digest"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["home_id"], name: "index_users_on_home_id"
  end

  add_foreign_key "bookmarks", "folders"
  add_foreign_key "books", "book_names"
  add_foreign_key "folders", "homes"
  add_foreign_key "slides", "homes"
  add_foreign_key "song_edits", "songs"
  add_foreign_key "songs", "homes"
  add_foreign_key "users", "homes"
end
