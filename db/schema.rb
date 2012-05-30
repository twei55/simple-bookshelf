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

ActiveRecord::Schema.define(:version => 20120516165837) do

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "authors", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name",          :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "full_name"
    t.string   "full_name_reversed"
  end

  create_table "book_authors", :force => true do |t|
    t.integer  "author_id"
    t.integer  "book_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "books", :force => true do |t|
    t.string   "title",                                   :null => false
    t.string   "year",                                    :null => false
    t.string   "publisher",                               :null => false
    t.text     "abstract"
    t.text     "location"
    t.boolean  "publisher_is_author"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.boolean  "delta",                 :default => true, :null => false
  end

  create_table "books_formats", :id => false, :force => true do |t|
    t.integer  "book_id"
    t.integer  "format_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "books_formats", ["book_id"], :name => "index_books_formats_on_book_id"
  add_index "books_formats", ["format_id"], :name => "index_books_formats_on_format_id"

  create_table "books_nested_tags", :id => false, :force => true do |t|
    t.integer  "book_id"
    t.integer  "nested_tag_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "books_nested_tags", ["book_id"], :name => "index_books_nested_tags_on_book_id"
  add_index "books_nested_tags", ["nested_tag_id"], :name => "index_books_nested_tags_on_nested_tag_id"

  create_table "formats", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "nested_tags", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
