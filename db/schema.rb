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

ActiveRecord::Schema.define(:version => 20130111140543) do

  create_table "audiences", :force => true do |t|
    t.string   "audience"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "charges", :force => true do |t|
    t.integer  "user_id"
    t.integer  "document_id"
    t.string   "stripe_charge_id"
    t.integer  "amount",           :default => 0
    t.integer  "amount_refunded",  :default => 0
    t.integer  "stripe_fee"
    t.string   "failure_message"
    t.boolean  "paid",             :default => false
    t.boolean  "refunded",         :default => false
    t.string   "coupon"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "credit_applied"
  end

  create_table "coupons", :force => true do |t|
    t.string   "code"
    t.integer  "amount"
    t.integer  "percent"
    t.boolean  "active"
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
    t.integer  "genre_id"
    t.date     "deadline"
    t.boolean  "fiction"
    t.boolean  "comments_private",                   :default => true
    t.boolean  "accept_volunteers",                  :default => true
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.integer  "sentence_count"
    t.integer  "syllable_count"
    t.integer  "word_count"
    t.string   "book_icon_color"
    t.boolean  "active"
    t.boolean  "paid"
    t.integer  "word_count_three_or_more_syllables"
    t.integer  "cost"
  end

  create_table "feedbacks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "document_id"
    t.integer  "reader_rating",            :default => 0
    t.boolean  "accepted_by_user"
    t.integer  "bookmark"
    t.boolean  "reader_feedback_complete"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  create_table "genres", :force => true do |t|
    t.string   "genre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "action"
    t.text     "content"
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

  create_table "prices", :force => true do |t|
    t.string   "name"
    t.integer  "words_min"
    t.integer  "words_max"
    t.float    "cost"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "auth_token"
    t.hstore   "reading_preferences"
    t.integer  "plan_id"
    t.boolean  "admin"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "last_4_digits"
    t.string   "stripe_customer_id"
    t.integer  "credit_cents",        :default => 0
    t.string   "reading_level"
  end

  add_index "users", ["reading_preferences"], :name => "users_gin_reading_preferences"

  create_table "volunteers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "document_id"
    t.boolean  "invited"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
