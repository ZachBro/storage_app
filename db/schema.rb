# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_08_03_014226) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "details", force: :cascade do |t|
    t.integer "ticket_id"
    t.integer "amount"
    t.string "location"
    t.integer "room"
    t.string "aasm_state"
    t.integer "stored_employee_id"
    t.integer "retrieved_employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aasm_state"], name: "index_details_on_aasm_state"
    t.index ["room"], name: "index_details_on_room"
  end

  create_table "employees", force: :cascade do |t|
    t.integer "id_number"
    t.string "name"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id_number"], name: "index_employees_on_id_number", unique: true
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "number"
    t.string "name"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tickets_on_name"
    t.index ["number"], name: "index_tickets_on_number", unique: true
  end

end
