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

ActiveRecord::Schema.define(version: 2025_01_02_231343) do

  create_table "curricular_components", force: :cascade do |t|
    t.string "nome"
    t.string "serie"
    t.string "area"
    t.text "curso", default: "[]"
    t.integer "aulas"
    t.integer "responsible_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "second_professor_name"
    t.index ["responsible_id"], name: "index_curricular_components_on_responsible_id"
  end

  create_table "horarios", force: :cascade do |t|
    t.string "nome"
    t.integer "aulas"
    t.text "d1", default: "[]"
    t.text "d2", default: "[]"
    t.text "d3", default: "[]"
    t.text "d4", default: "[]"
    t.text "d5", default: "[]"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "curso"
    t.string "serie"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.string "nick_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "curricular_components", "teachers", column: "responsible_id"
end
