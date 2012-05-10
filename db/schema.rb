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

ActiveRecord::Schema.define(:version => 20120510101826) do

  create_table "movies", :force => true do |t|
    t.text     "cast_members"
    t.string   "title"
    t.string   "director"
    t.string   "genres"
    t.integer  "length"
    t.string   "mpaa_rating"
    t.string   "poster"
    t.float    "rating"
    t.date     "release_date"
    t.string   "tagline"
    t.string   "trailer"
    t.integer  "votes"
    t.integer  "year"
    t.integer  "imdb_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "movies", ["imdb_id"], :name => "index_movies_on_imdb_id"

end
