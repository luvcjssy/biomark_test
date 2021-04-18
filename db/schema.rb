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

ActiveRecord::Schema.define(version: 2021_04_18_152031) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "patient_labs", force: :cascade do |t|
    t.bigint "patient_id"
    t.string "lab_number"
    t.string "clinic_code"
    t.datetime "date_of_test"
    t.jsonb "lab_studies", default: {}
    t.index ["patient_id"], name: "index_patient_labs_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "id_number", limit: 7, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone_mobile"
    t.boolean "gender"
    t.date "date_of_birth"
  end

end
