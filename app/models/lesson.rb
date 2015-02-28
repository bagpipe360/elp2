class Lesson < ActiveRecord::Base
  attr_accessible :end_time, :rounded_time, :session_id, :start_time, :student_id, :student_paid, :teacher_id, :teacher_paid, :time_slot_id, :token
  
  belongs_to :teacher, :class_name => "User"
  belongs_to :student, :class_name => "User"
  belongs_to :service
  belongs_to :time_slot
  
  has_one :lesson_review

  
  
  
end
