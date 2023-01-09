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

ActiveRecord::Schema[7.0].define(version: 2023_01_09_071918) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "loto_prizes", force: :cascade do |t|
    t.bigint "loto_id", comment: "ロトID"
    t.integer "grade", null: false, comment: "等数"
    t.integer "winning_number", default: 0, comment: "当選口数"
    t.integer "winning_aoumnt", default: 0, comment: "当選額"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loto_id"], name: "index_loto_prizes_on_loto_id"
  end

  create_table "lotos", force: :cascade do |t|
    t.integer "type", null: false, comment: "種別"
    t.integer "times", null: false, comment: "開催回"
    t.date "lottery_date", null: false, comment: "抽選日"
    t.integer "sales_amount", comment: "販売実績額"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type", "times"], name: "index_lotos_on_type_and_times", unique: true
  end

end
