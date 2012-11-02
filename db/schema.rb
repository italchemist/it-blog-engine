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

ActiveRecord::Schema.define(:version => 20121102085311) do

  create_table "articles", :force => true do |t|
    t.string "title"
    t.text   "content"
    t.date   "date"
    t.string "permalink"
  end

  create_table "blog_articles", :force => true do |t|
    t.integer "article_id"
  end

  add_index "blog_articles", ["article_id"], :name => "index_blog_articles_on_article_id"

  create_table "project_articles", :force => true do |t|
    t.integer "project_id"
    t.integer "article_id"
  end

  add_index "project_articles", ["article_id"], :name => "index_project_articles_on_article_id"
  add_index "project_articles", ["project_id"], :name => "index_project_articles_on_project_id"

  create_table "projects", :force => true do |t|
    t.text "name"
    t.text "permalink"
  end

end
