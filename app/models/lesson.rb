class Lesson < ActiveRecord::Base
  attr_accessible :end_time, :rounded_time, :session_id, :start_time, :student_id, :student_paid, :teacher_id, :teacher_paid, :time_slot_id, :token
  
  belongs_to :teacher, :class_name => "User"
  belongs_to :student, :class_name => "User"
  belongs_to :service
  belongs_to :time_slot
  has_one :lesson_review
  has_one :lesson_problem
  
  
  #class constants
  @@lesson_cancel_threshold = 5.hours
  @@lesson_ready_threshold = 30.minutes
  @@lesson_cancel_threshold_time = Time.now - @@lesson_cancel_threshold
  @@time_before_show_ready = Time.now - @@lesson_ready_threshold
 
  def allow_lesson_cancel
    Time.now < @@lesson_cancel_threshold_time
  end

  def calculate_cost
    #grab lesson rate (or teacher rate if lesson rate null)
    if self.rate.blank?
      self.rounded_time * self.teacher.rate
    else
      self.rounded_time * self.rate
    end
  end
  
  def cancel(user_role)
    if user_role == 'teacher'
      if self.time_slot.start_time < @@lesson_cancel_threshold_time 
        self.cancelled = true
      else
        return false
      end
    else
      if self.time_slot.start_time < @@lesson_cancel_threshold_time 
        self.cancelled = true
      else
        false
      end      
    end
  end
  
  def class_time_state
    #A class can be missed, taken, scheduled, rescheduled, or cancelled.
    if self.missed
      'missed'
    elsif self.taken
      'taken'
    elsif self.scheduled
      'scheduled'
    #elsif self.rescheduled
      #'rescheduled
    elsif self.cancelled
      'cancelled'
    end
  end
  
  def end_lesson
    #mark end time and save rounded total time
    self.end_time = Time.now
    self.rounded_time = end_time - start_time
  end
  
  def missed
    self.end_time.blank? && self.time_slot.end_time <= Time.now
  end
  
  def missed_by_both
    self.missed_by_student && self.missed_by_teacher
  end
  
  def missed_by_student
    !self.student_ready
  end
  
  def missed_by_teacher
    !self.teacher_ready
  end
  
  def pretty_end
    self.end_time.strftime("%m/%d/%Y, %H:%M")   #=> "Printed on 11/19/2007"
  end
  
  def pretty_start      
    self.start_time.strftime("%m/%d/%Y, %H:%M")   #=> "Printed on 11/19/2007"
  end
  
  def pretty_time_till
    puts '------------- PRETTY TIME TILL'
    puts self.time_slot.start_time
    puts Time.now
    puts '--------------------------------'
#     debug_time = self.time_slot.start_time - 48.days
#     Time.now = debug_time
    time_diff = Time.diff( time_slot.start_time, Time.now, '%d')
    puts time_diff
    show_reasonable_time(self.time_slot.start_time, time_diff) 
  end
  
  def ready_to_start
     self.student_ready and self.teacher_ready and self.teacher.online and self.student.online
  end
  
  def report_problem(problem)
    lesson_problem = self.lesson_problem.build
    lesson_problem.problem = problem
    lesson_problem.save
  end
  
  def scheduled
    self.time_slot.start_time >= Time.now
  end
  
  def show_ready
    Time.now >= @@time_before_show_ready  
  end
  
  
  def show_reasonable_time(start_time, time_diff) 
    #Do not want to show large time values in hours or minutes. 
        puts '--------------------------------'
    puts '--------------------------------'
    puts start_time
    puts Time.now
    if start_time >= Time.now #class is in future
      if time_diff[:week] >= 1 or time_diff[:month] >= 1 or time_diff[:year] >= 1
        #'Class is on ' + start_time.strftime("%m/%d/%Y, %I:%M %P") + ', 
        'Class is in ' + time_diff[:diff]
      elsif time_diff[:day] >= 1
        'Class is coming up in ' + time_diff[:day].to_s + ' days.'
        #'On ' + start_time.strftime("%m/%d/%Y, %I:%M %P") + ', 
      elsif time_diff[:hour] >= 6
        #'Class is today at ' + start_time.strftime("%I:%M %P") + '! 
        'You have ' + time_diff[:hour].to_s + ' hours.' 
      else
        #show time
        #'Class begins at ' + start_time.strftime("%I:%M %P") + '! 
        'You have ' +
         time_diff[:hour].to_s + ' hours and ' +time_diff[:minute].to_s + ' minutes.'
      end
    else #Class is in past
      if time_diff[:week] >= 1 or time_diff[:month] >= 1 or time_diff[:year] >= 1
        #'Class is on ' + start_time.strftime("%m/%d/%Y, %I:%M %P") + ', 
        'Class was scheduled for ' + time_diff[:diff] + ' ago.'
      elsif time_diff[:day] >= 1
        'Class was scheduled for ' + time_diff[:day].to_s + ' days ago.'
        #'On ' + start_time.strftime("%m/%d/%Y, %I:%M %P") + ', 
      elsif time_diff[:hour] >= 6
        #'Class is today at ' + start_time.strftime("%I:%M %P") + '! 
       'Class was ' + time_diff[:hour].to_s + ' hours ago.'
      else
        #show time
        #'Class begins at ' + start_time.strftime("%I:%M %P") + '! 
        'Class was taken ' +
         time_diff[:hour].to_s + ' hours and ' +time_diff[:minute].to_s + ' minutes ago.'
      end
    end
  end
  
  def taken
    !self.end_time.blank? && self.end_time <= Time.now
  end
  
  def update_student_status(status)
     if status == 'true'
       self.student_ready = true
     else
       self.student_ready = false
     end
  end
  
  def update_teacher_status(status)
    puts status
    puts "CHECK STATUS"
    if status == 'true'
        self.teacher_ready = true
    else
        self.teacher_ready = false
    end
    self.save
  end
    
end
