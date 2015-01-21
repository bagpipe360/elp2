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

ActiveRecord::Schema.define(:version => 20150121011259) do

  create_table "applications", :force => true do |t|
    t.integer  "user_id"
    t.binary   "video_interview"
    t.integer  "interview_id"
    t.binary   "resume_upload"
    t.string   "education"
    t.integer  "admin_id"
    t.string   "status"
    t.date     "date_applied"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "favorite_teachers", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "student_id"
    t.string   "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "identities", :force => true do |t|
    t.integer  "user_id"
    t.string   "password_digest"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "interview_questions", :force => true do |t|
    t.integer  "question_id"
    t.string   "question"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "interviews", :force => true do |t|
    t.integer  "application_id"
    t.date     "date_completed"
    t.integer  "interview_score"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "languages", :force => true do |t|
    t.string   "language"
    t.string   "location"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lesson_reviews", :force => true do |t|
    t.integer  "lesson_id"
    t.integer  "score"
    t.string   "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lessons", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "student_id"
    t.integer  "time_slot_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "rounded_time"
    t.boolean  "student_paid"
    t.boolean  "teacher_paid"
    t.string   "token"
    t.string   "session_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "service_id"
  end

  create_table "levels", :force => true do |t|
    t.string   "level"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "remembered_ips", :force => true do |t|
    t.string   "ip_address"
    t.date     "date_accessed"
    t.boolean  "blocked"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "services", :force => true do |t|
    t.integer  "types_of_class_id"
    t.integer  "level_id"
    t.integer  "language_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "student_uses_services", :force => true do |t|
    t.integer  "service_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teacher_teaches_services", :force => true do |t|
    t.integer  "service_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "time_slots", :force => true do |t|
    t.integer  "user_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "types_of_classes", :force => true do |t|
    t.string   "type_of_class"
    t.string   "description"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role"
    t.date     "created_at",                 :null => false
    t.string   "description"
    t.binary   "profile_picture"
    t.boolean  "verified_terms_and_service"
    t.datetime "updated_at",                 :null => false
  end

end
