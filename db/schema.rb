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

ActiveRecord::Schema.define(version: 2022_06_02_014040) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mensajes", force: :cascade do |t|
    t.string "contenido"
    t.bigint "user_id", null: false
    t.bigint "turno_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["turno_id"], name: "index_mensajes_on_turno_id"
    t.index ["user_id"], name: "index_mensajes_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.string "estado"
    t.text "descripcion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "id_usuario_solicitud"
    t.bigint "turno_id", null: false
    t.bigint "user_id", null: false
    t.index ["turno_id"], name: "index_requests_on_turno_id"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "resenas", force: :cascade do |t|
    t.text "contenido"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "turno_id"
    t.bigint "user_id"
    t.integer "calificacion"
    t.index ["turno_id"], name: "index_resenas_on_turno_id"
    t.index ["user_id"], name: "index_resenas_on_user_id"
  end

  create_table "turnos", force: :cascade do |t|
    t.integer "cantidad_asientos"
    t.string "hora_salida"
    t.string "direccion_salida"
    t.string "direccion_llegada"
    t.string "dia_semana"
    t.string "tipo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "estado"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_turnos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.text "address"
    t.text "description"
    t.string "gender"
    t.string "phone"
    t.string "foto"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "mensajes", "turnos"
  add_foreign_key "mensajes", "users"
  add_foreign_key "requests", "turnos"
  add_foreign_key "requests", "users"
  add_foreign_key "resenas", "turnos"
  add_foreign_key "resenas", "users"
  add_foreign_key "turnos", "users"
end
