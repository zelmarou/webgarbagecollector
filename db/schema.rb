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

ActiveRecord::Schema.define(:version => 20110616235344) do

  create_table "homes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", :force => true do |t|
    t.string   "param_title"
    t.date     "param_doc"
    t.integer  "param_size"
    t.string   "param_path"
    t.integer  "param_hits"
    t.integer  "param_mark"
    t.string   "param_desc"
    t.string   "param_thumb"
    t.integer  "param_type"
    t.date     "param_wiki_date"
    t.string   "param_wiki_author"
    t.string   "param_wiki_country"
    t.string   "param_wiki_story"
    t.string   "param_wiki_links"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "movieclip_file_name"
    t.string   "movieclip_content_type"
    t.integer  "movieclip_file_size"
    t.datetime "movieclip_updated_at"
    t.integer  "views_count"
  end

  create_table "wikis", :force => true do |t|
    t.integer  "video_id"
    t.string   "param_desc"
    t.date     "param_wiki_date"
    t.string   "param_wiki_author"
    t.string   "param_wiki_country"
    t.string   "param_wiki_story"
    t.string   "param_wiki_links"
    t.integer  "param_count_ok"
    t.integer  "param_count_ko"
    t.date     "param_wiki_edit_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
