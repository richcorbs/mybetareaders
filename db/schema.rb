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

ActiveRecord::Schema.define(:version => 20121024122550) do

  create_table "audiences", :force => true do |t|
    t.string   "audience"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "criteria", :force => true do |t|
    t.string   "criterium"
    t.text     "description"
    t.boolean  "fiction"
    t.boolean  "nonfiction"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "doctypes", :force => true do |t|
    t.string   "doctype"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "documents", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.string   "doctype"
    t.string   "description"
    t.string   "book_jacket_color"
    t.string   "book_binding_color"
    t.integer  "audience_id"
    t.integer  "genre_id"
    t.date     "deadline"
    t.boolean  "fiction"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "feedbacks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "document_id"
    t.integer  "reader_rating",    :default => 0
    t.boolean  "accepted_by_user"
    t.integer  "bookmark"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "genres", :force => true do |t|
    t.string   "genre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "paragraph_comments", :force => true do |t|
    t.integer  "paragraph_id"
    t.integer  "user_id"
    t.text     "comment"
    t.boolean  "writer_flagged", :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "paragraph_ratings", :force => true do |t|
    t.integer  "paragraph_id"
    t.integer  "user_id"
    t.hstore   "ratings"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "paragraphs", :force => true do |t|
    t.integer  "document_id"
    t.text     "text"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "auth_token"
    t.hstore   "reading_preferences"
    t.boolean  "admin"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "users", ["reading_preferences"], :name => "users_gin_reading_preferences"

end
