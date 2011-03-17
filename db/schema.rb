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

ActiveRecord::Schema.define(:version => 20110317080805) do

  create_table "external_photos", :force => true do |t|
    t.integer  "listing_id"
    t.string   "raw_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "large_url"
    t.string   "medium_url"
    t.string   "small_url"
  end

  create_table "forums", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listing_categories", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listings", :force => true do |t|
    t.boolean  "lost"
    t.string   "title"
    t.string   "description"
    t.string   "longitude"
    t.string   "latitude"
    t.datetime "last_seen_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "listing_category_id"
    t.string   "reverse_geocode"
    t.float    "value"
    t.float    "reward"
    t.boolean  "is_open",             :default => true
  end

  create_table "posts", :force => true do |t|
    t.string   "text"
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.integer  "forum_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "text"
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "time_zone_str"
    t.string   "reverse_geocode"
    t.string   "display_name"
    t.integer  "emails_sent",                         :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
