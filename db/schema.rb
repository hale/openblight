# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120328004730) do

  create_table "addresses", :force => true do |t|
    t.integer  "geopin"
    t.integer  "address_id"
    t.integer  "street_id"
    t.integer  "parcel_id"
    t.string   "house_num"
    t.string   "street_name"
    t.string   "street_type"
    t.string   "address_long"
    t.string   "case_district"
    t.float    "x"
    t.float    "y"
    t.string   "status"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "case_managers", :force => true do |t|
    t.string   "case"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cases", :force => true do |t|
    t.string   "case_number"
    t.integer  "geopin"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "demolitions", :force => true do |t|
    t.string   "case_number"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "foreclosures", :force => true do |t|
    t.string   "case_number"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "hearings", :force => true do |t|
    t.datetime "hearing_date"
    t.string   "hearing_time"
    t.string   "hearing_status"
    t.boolean  "reset_hearing"
    t.string   "hearing_result"
    t.integer  "one_time_fine"
    t.integer  "court_cost"
    t.integer  "recordation_cost"
    t.integer  "hearing_fines_owed"
    t.integer  "daily_fines_owed"
    t.integer  "fines_paid"
    t.datetime "date_paid"
    t.integer  "amount_still_owed"
    t.integer  "grace_days"
    t.datetime "grace_end"
    t.string   "case_manager"
    t.integer  "tax_id"
    t.string   "case_number"
    t.integer  "notice_id"
    t.integer  "inspection_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "inspections", :force => true do |t|
    t.string   "case_number"
    t.string   "result"
    t.date     "scheduled_date"
    t.date     "inspection_date"
    t.string   "inspection_type"
    t.integer  "inspector_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "inspectors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "judgements", :force => true do |t|
    t.string   "case_number"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "maintenances", :force => true do |t|
    t.string   "house_num"
    t.string   "street_name"
    t.string   "street_type"
    t.string   "address_long"
    t.string   "program_name"
    t.datetime "date_recorded"
    t.datetime "date_completed"
    t.datetime "status"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "notifications", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "properties", :force => true do |t|
    t.string   "street"
    t.integer  "number"
    t.integer  "zip_code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "resets", :force => true do |t|
    t.string   "case_number"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
