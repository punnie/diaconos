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

ActiveRecord::Schema.define(:version => 20120515131040) do

  create_table "events", :force => true do |t|
    t.date     "day"
    t.string   "status",     :default => "unspoken"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "movies", :force => true do |t|
    t.string   "title",                       :null => false
    t.text     "cast_members"
    t.string   "director"
    t.string   "genres"
    t.integer  "length"
    t.string   "mpaa_rating"
    t.string   "poster"
    t.float    "rating"
    t.integer  "rating_votes"
    t.date     "release_date"
    t.string   "tagline"
    t.string   "trailer"
    t.integer  "year"
    t.integer  "imdb_id",                     :null => false
    t.integer  "event_id"
    t.integer  "vote_count",   :default => 1
    t.string   "image"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.text     "plot"
  end

  add_index "movies", ["event_id"], :name => "index_movies_on_event_id"
  add_index "movies", ["imdb_id"], :name => "index_movies_on_imdb_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.boolean  "admin",               :default => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "password_encrypted"
    t.string   "password_salt"
    t.boolean  "confirmed"
    t.string   "single_access_token"
    t.string   "persistance_token"
  end

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "movie_id"
    t.string   "direction"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "votes", ["movie_id"], :name => "index_votes_on_movie_id"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

end
