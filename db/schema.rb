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

ActiveRecord::Schema.define(:version => 1) do

  create_table "calendar_event", :force => true do |t|
    t.integer  "userId",        :limit => 8,          :null => false
    t.integer  "calendarId",    :limit => 8,          :null => false
    t.text     "repeatType",    :limit => 2147483647, :null => false
    t.string   "startTime",                           :null => false
    t.string   "endTime",                             :null => false
    t.datetime "creation_date",                       :null => false
    t.text     "description",   :limit => 2147483647
    t.string   "subject"
    t.datetime "update_date",                         :null => false
    t.boolean  "locked",                              :null => false
    t.integer  "dol_id"
    t.string   "dol_name"
    t.integer  "event_dol_id"
  end

  add_index "calendar_event", ["calendarId"], :name => "FK2A9BEA59743E7F7"
  add_index "calendar_event", ["userId"], :name => "FK2A9BEA59581C403A"

  create_table "calendar_event_reminder", :force => true do |t|
    t.integer "eventId", :null => false
    t.string  "type",    :null => false
    t.integer "early",   :null => false
    t.string  "unit",    :null => false
    t.string  "alerted", :null => false
  end

  create_table "calendar_setting", :primary_key => "userId", :force => true do |t|
    t.string  "hourFormat"
    t.string  "dayFormat"
    t.string  "weekFormat"
    t.string  "monthFormat"
    t.string  "fromtoFormat"
    t.string  "activeStartTime",                   :null => false
    t.string  "activeEndTime",                     :null => false
    t.boolean "createByDblclick",                  :null => false
    t.boolean "hideInactiveRow",                   :null => false
    t.boolean "singleDay",                         :null => false
    t.string  "language",                          :null => false
    t.integer "intervalSlot",     :default => 30,  :null => false
    t.string  "startDay",         :default => "0", :null => false
    t.boolean "readOnly"
    t.integer "initialView",                       :null => false
  end

  create_table "calendar_type", :force => true do |t|
    t.integer  "userId",                              :null => false
    t.string   "color",                               :null => false
    t.datetime "creation_date",                       :null => false
    t.text     "description",   :limit => 2147483647
    t.boolean  "hide"
    t.string   "name",                                :null => false
    t.datetime "update_date",                         :null => false
  end

  add_index "calendar_type", ["userId"], :name => "FK7503A39B581C403A"

  create_table "user", :force => true do |t|
    t.string "description",              :null => false
    t.string "email",                    :null => false
    t.binary "email_show",  :limit => 1, :null => false
    t.binary "enabled",     :limit => 1, :null => false
    t.string "first_name",               :null => false
    t.string "last_name",                :null => false
    t.string "passwd",                   :null => false
    t.string "username",                 :null => false
  end

  add_index "user", ["username"], :name => "username", :unique => true

end
