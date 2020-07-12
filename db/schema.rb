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

ActiveRecord::Schema.define(version: 2020_07_10_225107) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "donations", force: :cascade do |t|
    t.decimal "amount", precision: 8, scale: 2, default: "0.0", null: false
    t.bigint "non_profit_id"
    t.uuid "payment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["non_profit_id"], name: "index_donations_on_non_profit_id"
    t.index ["payment_id"], name: "index_donations_on_payment_id"
  end

  create_table "non_profits", force: :cascade do |t|
    t.string "name", null: false
    t.string "address"
    t.boolean "member", default: false
    t.decimal "unpaid_donation_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "amount", precision: 9, scale: 2, default: "0.0", null: false
    t.boolean "fulfilled", default: false
    t.bigint "non_profit_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["non_profit_id"], name: "index_payments_on_non_profit_id"
  end

  add_foreign_key "donations", "non_profits"
  add_foreign_key "payments", "non_profits"
end
