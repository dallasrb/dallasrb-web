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

ActiveRecord::Schema.define(:version => 20130509222635) do

  create_table "event_addresses", :force => true do |t|
    t.integer  "event_id"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "address"
    t.string   "venue"
    t.boolean  "gmaps"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "event_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.integer  "event_type_id"
    t.datetime "event_date"
    t.string   "speaker"
    t.string   "title"
    t.text     "description"
    t.string   "slug"
    t.string   "rsvp_url"
    t.boolean  "published"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "events", ["slug"], :name => "index_events_on_slug"

  create_table "profiles", :force => true do |t|
    t.string   "name"
    t.text     "blurb"
    t.string   "twitter"
    t.string   "github"
    t.string   "email"
    t.string   "homepage"
    t.boolean  "organizer"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.boolean  "approved"
    t.integer  "sort_order", :default => 0
    t.integer  "user_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
