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

ActiveRecord::Schema.define(:version => 20130602034514) do

  create_table "course_reviews", :force => true do |t|
    t.integer  "course_id"
    t.integer  "status",     :default => 0
    t.text     "comments"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "courses", :force => true do |t|
    t.date     "date",       :null => false
    t.integer  "idx",        :null => false
    t.string   "title",      :null => false
    t.integer  "teacher_id", :null => false
    t.string   "cls",        :null => false
    t.integer  "field_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "facilities", :force => true do |t|
    t.string   "name",                                         :null => false
    t.string   "unit",                                         :null => false
    t.text     "description"
    t.text     "comments"
    t.string   "asset_id",                                     :null => false
    t.integer  "facility_type",                                :null => false
    t.integer  "alert_amount",                                 :null => false
    t.decimal  "unit_price",    :precision => 22, :scale => 2
    t.integer  "department_id",                                :null => false
    t.integer  "category_id",                                  :null => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  create_table "facility_applications", :force => true do |t|
    t.integer  "course_id"
    t.integer  "facility_id"
    t.integer  "applied",     :default => 0, :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "facility_categories", :force => true do |t|
    t.string   "name"
    t.text     "comments"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "facility_ios", :force => true do |t|
    t.integer  "facility_id"
    t.integer  "amount"
    t.integer  "owner_id"
    t.integer  "reason_id"
    t.date     "date"
    t.text     "comments"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "facility_properties", :force => true do |t|
    t.integer  "facility_id"
    t.string   "property_name"
    t.string   "property_value"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "facility_reasons", :force => true do |t|
    t.string   "reason"
    t.boolean  "if_add",     :default => false, :null => false
    t.boolean  "systematic", :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "facility_returns", :force => true do |t|
    t.integer  "application_id"
    t.text     "comments"
    t.integer  "borrowed_amount"
    t.datetime "borrowed_time"
    t.integer  "returned_amount"
    t.datetime "returned_time"
    t.integer  "status",          :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "facility_totals", :force => true do |t|
    t.integer  "facility_id"
    t.integer  "total",       :default => 0, :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "field_statuses", :force => true do |t|
    t.string   "name"
    t.boolean  "available",  :default => false, :null => false
    t.boolean  "systematic", :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "fields", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "status_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "plants", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "status_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "practice_records", :force => true do |t|
    t.integer  "course_id"
    t.text     "record"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "record_reviews", :force => true do |t|
    t.integer  "record_id"
    t.integer  "status",     :default => 0, :null => false
    t.text     "comments"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "friendly_name"
    t.text     "description"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "scheduled_courses", :force => true do |t|
    t.integer  "teacher_id", :null => false
    t.date     "begin_date", :null => false
    t.date     "end_date",   :null => false
    t.integer  "wday",       :null => false
    t.string   "cls",        :null => false
    t.string   "title",      :null => false
    t.integer  "field_id"
    t.integer  "idx",        :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "scheduled_facilities", :force => true do |t|
    t.integer  "schedule_id"
    t.string   "facility_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "stocking_details", :force => true do |t|
    t.integer  "stocking_id"
    t.integer  "facility_id"
    t.integer  "old_amount"
    t.integer  "new_amount"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "stockings", :force => true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "title"
    t.text     "comments"
    t.integer  "owner_id"
    t.boolean  "finished"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_role_mappings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "account"
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
