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

ActiveRecord::Schema.define(:version => 20150307172034) do

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
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "invitation_token"
  end

  add_index "identities", ["confirmation_token"], :name => "index_identities_on_confirmation_token", :unique => true
  add_index "identities", ["email"], :name => "index_identities_on_email", :unique => true
  add_index "identities", ["reset_password_token"], :name => "index_identities_on_reset_password_token", :unique => true
  add_index "identities", ["unlock_token"], :name => "index_identities_on_unlock_token", :unique => true

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
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "service_id"
    t.boolean  "student_ready", :default => false
    t.boolean  "teacher_ready", :default => false
  end

  create_table "levels", :force => true do |t|
    t.string   "level"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "rank"
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
    t.date     "created_at",                                    :null => false
    t.string   "description"
    t.binary   "profile_picture"
    t.boolean  "verified_terms_and_service"
    t.datetime "updated_at",                                    :null => false
    t.boolean  "online",                     :default => false
  end

end
