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

ActiveRecord::Schema.define(:version => 20131215232700) do

  create_table "applications", :force => true do |t|
    t.integer  "user_id"
    t.string   "phone"
    t.date     "date_of_birth"
    t.date     "date_of_graduation"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "are_you_a_graduating_high_school_senior"
    t.boolean  "out_and_open"
    t.boolean  "identify_supporter"
    t.boolean  "supportive_parents"
    t.string   "how_did_you_learn_about_the_scholarship"
    t.string   "name_of_high_school"
    t.string   "hs_street_address"
    t.string   "hs_city"
    t.string   "hs_state"
    t.string   "hs_zip"
    t.string   "cumulative_gpa"
    t.text     "please_lists_schools_where_you_will_be_applying"
    t.text     "describe_community_service_activities"
    t.string   "essay"
    t.boolean  "release_high_school"
    t.boolean  "release_local_media"
    t.boolean  "release_national_media"
    t.boolean  "release_local_chapter"
    t.boolean  "release_photograph"
    t.boolean  "release_essay_collection"
    t.boolean  "release_picture_bio_on_website"
    t.integer  "reference_id"
    t.datetime "signature_stamp"
    t.string   "signature_ip"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.text     "honors_or_awards"
    t.boolean  "identify_lgbt"
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
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end